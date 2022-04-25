Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A19A050E898
	for <lists+linux-arch@lfdr.de>; Mon, 25 Apr 2022 20:48:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244592AbiDYSty (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 25 Apr 2022 14:49:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244572AbiDYStu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 25 Apr 2022 14:49:50 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 963286F9E0;
        Mon, 25 Apr 2022 11:46:45 -0700 (PDT)
Received: from localhost.localdomain (c-73-140-2-214.hsd1.wa.comcast.net [73.140.2.214])
        by linux.microsoft.com (Postfix) with ESMTPSA id F163520E8CB6;
        Mon, 25 Apr 2022 11:46:44 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com F163520E8CB6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1650912405;
        bh=XIzO1LLVQCb9A01YoSu8+i/AWBjBDCwqrp4WnDv6/j4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rTHAwlZUH3k98C7f21qPFMAu4n4y+aqsM1JjbN+5oq6EdjxeKa++t4q5Zq0njMiKZ
         swL7AhompWdTaMku2hQEs4aQhLiJFcA+utTWyIPzMewjjXSv+m6QQrKCJt/6H4scz+
         TdKgAnk5GtsPBenBO3Y23zEVvJKucSFzHSqysBtY=
From:   Beau Belgrave <beaub@linux.microsoft.com>
To:     rostedt@goodmis.org, mhiramat@kernel.org,
        mathieu.desnoyers@efficios.com
Cc:     linux-trace-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, beaub@linux.microsoft.com
Subject: [PATCH v2 7/7] tracing/user_events: Update ABI documentation to align to bits vs bytes
Date:   Mon, 25 Apr 2022 11:46:31 -0700
Message-Id: <20220425184631.2068-8-beaub@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220425184631.2068-1-beaub@linux.microsoft.com>
References: <20220425184631.2068-1-beaub@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Update the documentation to reflect the new ABI requirements and how to
use the byte index with the mask properly to check event status.

Signed-off-by: Beau Belgrave <beaub@linux.microsoft.com>
---
 Documentation/trace/user_events.rst | 86 +++++++++++++++++++----------
 1 file changed, 58 insertions(+), 28 deletions(-)

diff --git a/Documentation/trace/user_events.rst b/Documentation/trace/user_events.rst
index c180936f49fc..9f181f342a70 100644
--- a/Documentation/trace/user_events.rst
+++ b/Documentation/trace/user_events.rst
@@ -20,14 +20,14 @@ dynamic_events is the same as the ioctl with the u: prefix applied.
 
 Typically programs will register a set of events that they wish to expose to
 tools that can read trace_events (such as ftrace and perf). The registration
-process gives back two ints to the program for each event. The first int is the
-status index. This index describes which byte in the
+process gives back two ints to the program for each event. The first int is
+the status bit. This describes which bit in little-endian format in the
 /sys/kernel/debug/tracing/user_events_status file represents this event. The
-second int is the write index. This index describes the data when a write() or
+second int is the write index which describes the data when a write() or
 writev() is called on the /sys/kernel/debug/tracing/user_events_data file.
 
-The structures referenced in this document are contained with the
-/include/uap/linux/user_events.h file in the source tree.
+The structures referenced in this document are contained within the
+/include/uapi/linux/user_events.h file in the source tree.
 
 **NOTE:** *Both user_events_status and user_events_data are under the tracefs
 filesystem and may be mounted at different paths than above.*
@@ -38,18 +38,18 @@ Registering within a user process is done via ioctl() out to the
 /sys/kernel/debug/tracing/user_events_data file. The command to issue is
 DIAG_IOCSREG.
 
-This command takes a struct user_reg as an argument::
+This command takes a packed struct user_reg as an argument::
 
   struct user_reg {
         u32 size;
         u64 name_args;
-        u32 status_index;
+        u32 status_bit;
         u32 write_index;
   };
 
 The struct user_reg requires two inputs, the first is the size of the structure
 to ensure forward and backward compatibility. The second is the command string
-to issue for registering. Upon success two outputs are set, the status index
+to issue for registering. Upon success two outputs are set, the status bit
 and the write index.
 
 User based events show up under tracefs like any other event under the
@@ -111,15 +111,56 @@ in realtime. This allows user programs to only incur the cost of the write() or
 writev() calls when something is actively attached to the event.
 
 User programs call mmap() on /sys/kernel/debug/tracing/user_events_status to
-check the status for each event that is registered. The byte to check in the
-file is given back after the register ioctl() via user_reg.status_index.
+check the status for each event that is registered. The bit to check in the
+file is given back after the register ioctl() via user_reg.status_bit. The bit
+is always in little-endian format. Programs can check if the bit is set either
+using a byte-wise index with a mask or a long-wise index with a little-endian
+mask.
+
 Currently the size of user_events_status is a single page, however, custom
 kernel configurations can change this size to allow more user based events. In
 all cases the size of the file is a multiple of a page size.
 
-For example, if the register ioctl() gives back a status_index of 3 you would
-check byte 3 of the returned mmap data to see if anything is attached to that
-event.
+For example, if the register ioctl() gives back a status_bit of 3 you would
+check byte 0 (3 / 8) of the returned mmap data and then AND the result with 8
+(1 << (3 % 8)) to see if anything is attached to that event.
+
+A byte-wise index check is performed as follows::
+
+  int index, mask;
+  char *status_page;
+
+  index = status_bit / 8;
+  mask = 1 << (status_bit % 8);
+
+  ...
+
+  if (status_page[index] & mask) {
+        /* Enabled */
+  }
+
+A long-wise index check is performed as follows::
+
+  #include <asm/bitsperlong.h>
+  #include <endian.h>
+
+  #if __BITS_PER_LONG == 64
+  #define endian_swap(x) htole64(x)
+  #else
+  #define endian_swap(x) htole32(x)
+  #endif
+
+  long index, mask, *status_page;
+
+  index = status_bit / __BITS_PER_LONG;
+  mask = 1L << (status_bit % __BITS_PER_LONG);
+  mask = endian_swap(mask);
+
+  ...
+
+  if (status_page[index] & mask) {
+        /* Enabled */
+  }
 
 Administrators can easily check the status of all registered events by reading
 the user_events_status file directly via a terminal. The output is as follows::
@@ -137,7 +178,7 @@ For example, on a system that has a single event the output looks like this::
 
   Active: 1
   Busy: 0
-  Max: 4096
+  Max: 32768
 
 If a user enables the user event via ftrace, the output would change to this::
 
@@ -145,21 +186,10 @@ If a user enables the user event via ftrace, the output would change to this::
 
   Active: 1
   Busy: 1
-  Max: 4096
-
-**NOTE:** *A status index of 0 will never be returned. This allows user
-programs to have an index that can be used on error cases.*
-
-Status Bits
-^^^^^^^^^^^
-The byte being checked will be non-zero if anything is attached. Programs can
-check specific bits in the byte to see what mechanism has been attached.
-
-The following values are defined to aid in checking what has been attached:
-
-**EVENT_STATUS_FTRACE** - Bit set if ftrace has been attached (Bit 0).
+  Max: 32768
 
-**EVENT_STATUS_PERF** - Bit set if perf has been attached (Bit 1).
+**NOTE:** *A status bit of 0 will never be returned. This allows user programs
+to have a bit that can be used on error cases.*
 
 Writing Data
 ------------
-- 
2.25.1

