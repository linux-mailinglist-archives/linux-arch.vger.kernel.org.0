Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DD634EFD36
	for <lists+linux-arch@lfdr.de>; Sat,  2 Apr 2022 01:43:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353482AbiDAXpX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 1 Apr 2022 19:45:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353456AbiDAXpS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 1 Apr 2022 19:45:18 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2A61F2DF7;
        Fri,  1 Apr 2022 16:43:27 -0700 (PDT)
Received: from localhost.localdomain (c-73-140-2-214.hsd1.wa.comcast.net [73.140.2.214])
        by linux.microsoft.com (Postfix) with ESMTPSA id 20B5920DF570;
        Fri,  1 Apr 2022 16:43:25 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 20B5920DF570
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1648856605;
        bh=dxneIxyFrTOTz7WRpQU5x5JzmKlH6pr4TBlRuoXEHsU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n5KSa9Db49+uG+J/PM8NwppUB1DtfCKpVLACIieSGy329S5K8EPhCwDPpFNnB/O0H
         h24uG7buNojo2g6phn7T+Zx5shTFUHdFO4yUKUkLP/Q7OMEq7DrNKnI793gEqEMTiQ
         vxN0TENfcqj5qFpXdVkMfjShUxPv8QvrHtQOQfDE=
From:   Beau Belgrave <beaub@linux.microsoft.com>
To:     rostedt@goodmis.org, mhiramat@kernel.org,
        mathieu.desnoyers@efficios.com
Cc:     linux-trace-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, beaub@linux.microsoft.com
Subject: [PATCH 7/7] tracing/user_events: Update ABI documentation to align to bits vs bytes
Date:   Fri,  1 Apr 2022 16:43:09 -0700
Message-Id: <20220401234309.21252-8-beaub@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220401234309.21252-1-beaub@linux.microsoft.com>
References: <20220401234309.21252-1-beaub@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Update the documentation to reflect the new ABI requirements and how to
use the byte index with the mask properly to check event status.

Signed-off-by: Beau Belgrave <beaub@linux.microsoft.com>
---
 Documentation/trace/user_events.rst | 46 +++++++++++++----------------
 1 file changed, 21 insertions(+), 25 deletions(-)

diff --git a/Documentation/trace/user_events.rst b/Documentation/trace/user_events.rst
index c180936f49fc..6aabdb126f2e 100644
--- a/Documentation/trace/user_events.rst
+++ b/Documentation/trace/user_events.rst
@@ -20,14 +20,15 @@ dynamic_events is the same as the ioctl with the u: prefix applied.
 
 Typically programs will register a set of events that they wish to expose to
 tools that can read trace_events (such as ftrace and perf). The registration
-process gives back two ints to the program for each event. The first int is the
-status index. This index describes which byte in the
+process gives back three ints to the program for each event. The first int is
+the status index. This index describes which byte in the
 /sys/kernel/debug/tracing/user_events_status file represents this event. The
-second int is the write index. This index describes the data when a write() or
-writev() is called on the /sys/kernel/debug/tracing/user_events_data file.
+second int is the mask to use on the byte to check the event status. The third
+int is the write index which describes the data when a write() or writev() is
+called on the /sys/kernel/debug/tracing/user_events_data file.
 
-The structures referenced in this document are contained with the
-/include/uap/linux/user_events.h file in the source tree.
+The structures referenced in this document are contained within the
+/include/uapi/linux/user_events.h file in the source tree.
 
 **NOTE:** *Both user_events_status and user_events_data are under the tracefs
 filesystem and may be mounted at different paths than above.*
@@ -44,6 +45,7 @@ This command takes a struct user_reg as an argument::
         u32 size;
         u64 name_args;
         u32 status_index;
+        u32 status_mask;
         u32 write_index;
   };
 
@@ -112,14 +114,19 @@ writev() calls when something is actively attached to the event.
 
 User programs call mmap() on /sys/kernel/debug/tracing/user_events_status to
 check the status for each event that is registered. The byte to check in the
-file is given back after the register ioctl() via user_reg.status_index.
+file is given back after the register ioctl() via user_reg.status_index. The
+byte needs to be AND'd with the user_reg.status_mask value to check if the
+event is enabled currently.
+
 Currently the size of user_events_status is a single page, however, custom
 kernel configurations can change this size to allow more user based events. In
 all cases the size of the file is a multiple of a page size.
 
-For example, if the register ioctl() gives back a status_index of 3 you would
-check byte 3 of the returned mmap data to see if anything is attached to that
-event.
+For example, if the register ioctl() gives back a status_index of 3 and a mask
+of 1 you would check byte 3 of the returned mmap data and then AND the result
+with 1 (e.g. status_page[3] & 1) to see if anything is attached to that event.
+A helper function is available called user_event_enabled() which does this for
+you.
 
 Administrators can easily check the status of all registered events by reading
 the user_events_status file directly via a terminal. The output is as follows::
@@ -137,7 +144,7 @@ For example, on a system that has a single event the output looks like this::
 
   Active: 1
   Busy: 0
-  Max: 4096
+  Max: 32768
 
 If a user enables the user event via ftrace, the output would change to this::
 
@@ -145,21 +152,10 @@ If a user enables the user event via ftrace, the output would change to this::
 
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
+**NOTE:** *A status index of 0 with a mask of 1 will never be returned. This
+allows user programs to have an index and mask that can be used on error cases.*
 
 Writing Data
 ------------
-- 
2.25.1

