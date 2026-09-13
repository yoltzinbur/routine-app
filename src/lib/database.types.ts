export type Json =
  | string
  | number
  | boolean
  | null
  | { [key: string]: Json | undefined }
  | Json[]

export type Database = {
  // Allows to automatically instantiate createClient with right options
  // instead of createClient<Database, { PostgrestVersion: 'XX' }>(URL, KEY)
  __InternalSupabase: {
    PostgrestVersion: "14.5"
  }
  graphql_public: {
    Tables: {
      [_ in never]: never
    }
    Views: {
      [_ in never]: never
    }
    Functions: {
      graphql: {
        Args: {
          extensions?: Json
          operationName?: string
          query?: string
          variables?: Json
        }
        Returns: Json
      }
    }
    Enums: {
      [_ in never]: never
    }
    CompositeTypes: {
      [_ in never]: never
    }
  }
  public: {
    Tables: {
      activity_log: {
        Row: {
          action: Database["public"]["Enums"]["action_type"]
          created_at: string
          entity_title: string | null
          entity_type: Database["public"]["Enums"]["activity_entity"]
          id_activity: string
          id_event: string | null
          id_hub: string
          id_note: string | null
          id_routine: string | null
          user_id: string | null
        }
        Insert: {
          action: Database["public"]["Enums"]["action_type"]
          created_at?: string
          entity_title?: string | null
          entity_type: Database["public"]["Enums"]["activity_entity"]
          id_activity?: string
          id_event?: string | null
          id_hub: string
          id_note?: string | null
          id_routine?: string | null
          user_id?: string | null
        }
        Update: {
          action?: Database["public"]["Enums"]["action_type"]
          created_at?: string
          entity_title?: string | null
          entity_type?: Database["public"]["Enums"]["activity_entity"]
          id_activity?: string
          id_event?: string | null
          id_hub?: string
          id_note?: string | null
          id_routine?: string | null
          user_id?: string | null
        }
        Relationships: [
          {
            foreignKeyName: "activity_log_id_event_fkey"
            columns: ["id_event"]
            isOneToOne: false
            referencedRelation: "events"
            referencedColumns: ["id_event"]
          },
          {
            foreignKeyName: "activity_log_id_hub_fkey"
            columns: ["id_hub"]
            isOneToOne: false
            referencedRelation: "hubs"
            referencedColumns: ["id_hub"]
          },
          {
            foreignKeyName: "activity_log_id_note_fkey"
            columns: ["id_note"]
            isOneToOne: false
            referencedRelation: "notes"
            referencedColumns: ["id_note"]
          },
          {
            foreignKeyName: "activity_log_id_routine_fkey"
            columns: ["id_routine"]
            isOneToOne: false
            referencedRelation: "routine_blocks"
            referencedColumns: ["id_routine"]
          },
        ]
      }
      events: {
        Row: {
          activity: string | null
          created_at: string
          date_ended: string | null
          date_started: string
          id_event: string
          id_hub: string
          reminder: boolean
          shared: boolean
          time_ended: string | null
          time_started: string | null
          title: string
          updated_at: string
          user_id: string | null
        }
        Insert: {
          activity?: string | null
          created_at?: string
          date_ended?: string | null
          date_started: string
          id_event?: string
          id_hub: string
          reminder?: boolean
          shared?: boolean
          time_ended?: string | null
          time_started?: string | null
          title: string
          updated_at?: string
          user_id?: string | null
        }
        Update: {
          activity?: string | null
          created_at?: string
          date_ended?: string | null
          date_started?: string
          id_event?: string
          id_hub?: string
          reminder?: boolean
          shared?: boolean
          time_ended?: string | null
          time_started?: string | null
          title?: string
          updated_at?: string
          user_id?: string | null
        }
        Relationships: [
          {
            foreignKeyName: "events_id_hub_fkey"
            columns: ["id_hub"]
            isOneToOne: false
            referencedRelation: "hubs"
            referencedColumns: ["id_hub"]
          },
        ]
      }
      hub_invites: {
        Row: {
          code: string
          created_by: string
          expires_at: string
          id_hub: string
          id_invite: string
        }
        Insert: {
          code?: string
          created_by: string
          expires_at?: string
          id_hub: string
          id_invite?: string
        }
        Update: {
          code?: string
          created_by?: string
          expires_at?: string
          id_hub?: string
          id_invite?: string
        }
        Relationships: [
          {
            foreignKeyName: "hub_invites_id_hub_fkey"
            columns: ["id_hub"]
            isOneToOne: false
            referencedRelation: "hubs"
            referencedColumns: ["id_hub"]
          },
        ]
      }
      hub_members: {
        Row: {
          id_hub: string
          joined_at: string
          user_id: string
        }
        Insert: {
          id_hub: string
          joined_at?: string
          user_id: string
        }
        Update: {
          id_hub?: string
          joined_at?: string
          user_id?: string
        }
        Relationships: [
          {
            foreignKeyName: "hub_members_id_hub_fkey"
            columns: ["id_hub"]
            isOneToOne: false
            referencedRelation: "hubs"
            referencedColumns: ["id_hub"]
          },
        ]
      }
      hubs: {
        Row: {
          created_at: string
          created_by: string | null
          id_hub: string
          name: string
        }
        Insert: {
          created_at?: string
          created_by?: string | null
          id_hub?: string
          name: string
        }
        Update: {
          created_at?: string
          created_by?: string | null
          id_hub?: string
          name?: string
        }
        Relationships: []
      }
      notes: {
        Row: {
          content: string | null
          created_at: string
          file_url: string | null
          id_event: string | null
          id_hub: string
          id_note: string
          is_done: boolean | null
          routine_id: string | null
          shared: boolean
          title: string
          type: Database["public"]["Enums"]["note_types"]
          updated_at: string
          user_id: string | null
        }
        Insert: {
          content?: string | null
          created_at?: string
          file_url?: string | null
          id_event?: string | null
          id_hub: string
          id_note?: string
          is_done?: boolean | null
          routine_id?: string | null
          shared?: boolean
          title: string
          type?: Database["public"]["Enums"]["note_types"]
          updated_at?: string
          user_id?: string | null
        }
        Update: {
          content?: string | null
          created_at?: string
          file_url?: string | null
          id_event?: string | null
          id_hub?: string
          id_note?: string
          is_done?: boolean | null
          routine_id?: string | null
          shared?: boolean
          title?: string
          type?: Database["public"]["Enums"]["note_types"]
          updated_at?: string
          user_id?: string | null
        }
        Relationships: [
          {
            foreignKeyName: "notes_id_event_fkey"
            columns: ["id_event"]
            isOneToOne: false
            referencedRelation: "events"
            referencedColumns: ["id_event"]
          },
          {
            foreignKeyName: "notes_id_hub_fkey"
            columns: ["id_hub"]
            isOneToOne: false
            referencedRelation: "hubs"
            referencedColumns: ["id_hub"]
          },
          {
            foreignKeyName: "notes_routine_id_fkey"
            columns: ["routine_id"]
            isOneToOne: false
            referencedRelation: "routine_blocks"
            referencedColumns: ["id_routine"]
          },
        ]
      }
      routine_blocks: {
        Row: {
          color: string
          created_at: string
          day: Database["public"]["Enums"]["day_of_week"]
          id_routine: string
          time_ended: string
          time_started: string
          title: string
          updated_at: string
          user_id: string
        }
        Insert: {
          color?: string
          created_at?: string
          day: Database["public"]["Enums"]["day_of_week"]
          id_routine?: string
          time_ended: string
          time_started: string
          title: string
          updated_at?: string
          user_id: string
        }
        Update: {
          color?: string
          created_at?: string
          day?: Database["public"]["Enums"]["day_of_week"]
          id_routine?: string
          time_ended?: string
          time_started?: string
          title?: string
          updated_at?: string
          user_id?: string
        }
        Relationships: []
      }
    }
    Views: {
      [_ in never]: never
    }
    Functions: {
      is_hub_member: { Args: { check_hub_id: string }; Returns: boolean }
      join_hub_with_code: { Args: { hub_code: string }; Returns: string }
      shares_hub_with: { Args: { target_user: string }; Returns: boolean }
      timemultirange: { Args: never; Returns: unknown }
    }
    Enums: {
      action_type: "creado" | "editado" | "eliminado"
      activity_entity: "evento" | "rutina" | "nota"
      day_of_week:
        | "Domingo"
        | "Lunes"
        | "Martes"
        | "Miércoles"
        | "Jueves"
        | "Viernes"
        | "Sábado"
      note_types: "Texto" | "URL" | "To-Do" | "Ubicación" | "Archivo"
    }
    CompositeTypes: {
      [_ in never]: never
    }
  }
}

type DatabaseWithoutInternals = Omit<Database, "__InternalSupabase">

type DefaultSchema = DatabaseWithoutInternals[Extract<keyof Database, "public">]

export type Tables<
  DefaultSchemaTableNameOrOptions extends
    | keyof (DefaultSchema["Tables"] & DefaultSchema["Views"])
    | { schema: keyof DatabaseWithoutInternals },
  TableName extends (DefaultSchemaTableNameOrOptions extends {
    schema: keyof DatabaseWithoutInternals
  }
    ? keyof (DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Tables"] &
        DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Views"])
    : never) = never,
> = DefaultSchemaTableNameOrOptions extends {
  schema: keyof DatabaseWithoutInternals
}
  ? (DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Tables"] &
      DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Views"])[TableName] extends {
      Row: infer R
    }
    ? R
    : never
  : DefaultSchemaTableNameOrOptions extends keyof (DefaultSchema["Tables"] &
        DefaultSchema["Views"])
    ? (DefaultSchema["Tables"] &
        DefaultSchema["Views"])[DefaultSchemaTableNameOrOptions] extends {
        Row: infer R
      }
      ? R
      : never
    : never

export type TablesInsert<
  DefaultSchemaTableNameOrOptions extends
    | keyof DefaultSchema["Tables"]
    | { schema: keyof DatabaseWithoutInternals },
  TableName extends (DefaultSchemaTableNameOrOptions extends {
    schema: keyof DatabaseWithoutInternals
  }
    ? keyof DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Tables"]
    : never) = never,
> = DefaultSchemaTableNameOrOptions extends {
  schema: keyof DatabaseWithoutInternals
}
  ? DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Tables"][TableName] extends {
      Insert: infer I
    }
    ? I
    : never
  : DefaultSchemaTableNameOrOptions extends keyof DefaultSchema["Tables"]
    ? DefaultSchema["Tables"][DefaultSchemaTableNameOrOptions] extends {
        Insert: infer I
      }
      ? I
      : never
    : never

export type TablesUpdate<
  DefaultSchemaTableNameOrOptions extends
    | keyof DefaultSchema["Tables"]
    | { schema: keyof DatabaseWithoutInternals },
  TableName extends (DefaultSchemaTableNameOrOptions extends {
    schema: keyof DatabaseWithoutInternals
  }
    ? keyof DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Tables"]
    : never) = never,
> = DefaultSchemaTableNameOrOptions extends {
  schema: keyof DatabaseWithoutInternals
}
  ? DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Tables"][TableName] extends {
      Update: infer U
    }
    ? U
    : never
  : DefaultSchemaTableNameOrOptions extends keyof DefaultSchema["Tables"]
    ? DefaultSchema["Tables"][DefaultSchemaTableNameOrOptions] extends {
        Update: infer U
      }
      ? U
      : never
    : never

export type Enums<
  DefaultSchemaEnumNameOrOptions extends
    | keyof DefaultSchema["Enums"]
    | { schema: keyof DatabaseWithoutInternals },
  EnumName extends (DefaultSchemaEnumNameOrOptions extends {
    schema: keyof DatabaseWithoutInternals
  }
    ? keyof DatabaseWithoutInternals[DefaultSchemaEnumNameOrOptions["schema"]]["Enums"]
    : never) = never,
> = DefaultSchemaEnumNameOrOptions extends {
  schema: keyof DatabaseWithoutInternals
}
  ? DatabaseWithoutInternals[DefaultSchemaEnumNameOrOptions["schema"]]["Enums"][EnumName]
  : DefaultSchemaEnumNameOrOptions extends keyof DefaultSchema["Enums"]
    ? DefaultSchema["Enums"][DefaultSchemaEnumNameOrOptions]
    : never

export type CompositeTypes<
  PublicCompositeTypeNameOrOptions extends
    | keyof DefaultSchema["CompositeTypes"]
    | { schema: keyof DatabaseWithoutInternals },
  CompositeTypeName extends (PublicCompositeTypeNameOrOptions extends {
    schema: keyof DatabaseWithoutInternals
  }
    ? keyof DatabaseWithoutInternals[PublicCompositeTypeNameOrOptions["schema"]]["CompositeTypes"]
    : never) = never,
> = PublicCompositeTypeNameOrOptions extends {
  schema: keyof DatabaseWithoutInternals
}
  ? DatabaseWithoutInternals[PublicCompositeTypeNameOrOptions["schema"]]["CompositeTypes"][CompositeTypeName]
  : PublicCompositeTypeNameOrOptions extends keyof DefaultSchema["CompositeTypes"]
    ? DefaultSchema["CompositeTypes"][PublicCompositeTypeNameOrOptions]
    : never

export const Constants = {
  graphql_public: {
    Enums: {},
  },
  public: {
    Enums: {
      action_type: ["creado", "editado", "eliminado"],
      activity_entity: ["evento", "rutina", "nota"],
      day_of_week: [
        "Domingo",
        "Lunes",
        "Martes",
        "Miércoles",
        "Jueves",
        "Viernes",
        "Sábado",
      ],
      note_types: ["Texto", "URL", "To-Do", "Ubicación", "Archivo"],
    },
  },
} as const
