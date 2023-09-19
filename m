Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF3F87A6F43
	for <lists+linux-arch@lfdr.de>; Wed, 20 Sep 2023 01:11:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233806AbjISXKt (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 19 Sep 2023 19:10:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233872AbjISXJw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 19 Sep 2023 19:09:52 -0400
Received: from mail-yw1-x1143.google.com (mail-yw1-x1143.google.com [IPv6:2607:f8b0:4864:20::1143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83615CF2;
        Tue, 19 Sep 2023 16:09:35 -0700 (PDT)
Received: by mail-yw1-x1143.google.com with SMTP id 00721157ae682-59c0d002081so46629247b3.2;
        Tue, 19 Sep 2023 16:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695164973; x=1695769773; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/BzdU73mktIqrWEyNeRHFLneU5XHVXd3fWpZckENL4w=;
        b=UXzACK4N3/re7xF2XW+jOkf5pfT0ocgkXECmeLOjpAS5SxGtHC4ZRBMQOU51umH2bO
         esKMmOu2jkFgyhJ00bE/4/EGyaH+WnCauVDzOAVnbhiUgVmH+t7+2dpgg2784bEvo9CM
         o5Yy0kGhhOvnC4ptCO0AFbS2bY/Hz7g2cclNmg/yXSuJRbyVUer58aFHWauvpDV2C8n4
         Eei0aqaZxbsNeAp1sUKcyl1kP36dGlnGv9TidjdGBZKqCPzhWJOb4xoEI1RT6eJz+82I
         jobOm764QdaLICs8PxQW54cyHojsMBvLLN/BvSvtOYAnSGpX93B/NBKn5d6uernzfTeQ
         Zl9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695164973; x=1695769773;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/BzdU73mktIqrWEyNeRHFLneU5XHVXd3fWpZckENL4w=;
        b=qs8YycmF8Fn0QzMjG+kAebHKBu0YRxpWOlnhIO5lyaKeQNC1BkOsFVRjvvVMGd4ocK
         2ieue+1LjiVT+1NORz0KGTr4QSOvIWRu+MGaqVrxn8yo1DhvDupPHWZ2GEuwQAO3kq+j
         k6r8am6+ePSYw9t38AkQisGPT/A4AQI42CNDPiXmwIQBaXEvaTQbLLDD34BZ0Q3St3iN
         NDe1mEOe5/RSZMDe35RHatkijo/ldvtqVESSBakVpjG3PUrBPXJ4Ddn2MB6z0b7YtiMq
         49JV6aOhToNJKs1FOpjf0bfQwG5vbkcAZtHhlz9sVV+hZak60mCR/g0Kk3s7GZEXvQhW
         2Rlw==
X-Gm-Message-State: AOJu0YzA3HemYlf981kCLZrkv1VZn5crHaLV82Kr0tTH1ve2jI/oXLq8
        yQjXa0oklI3+i5kLCaCzaDAQBI7M6Oz9
X-Google-Smtp-Source: AGHT+IEGzqsUSzvId2myP+hPQ2p9TRAtPvWclhtlR5tPTKUOOrnYit3Dm1RBYDVR9SzhNAv67W9RLQ==
X-Received: by 2002:a0d:fb81:0:b0:583:b2a3:f780 with SMTP id l123-20020a0dfb81000000b00583b2a3f780mr891122ywf.49.1695164973322;
        Tue, 19 Sep 2023 16:09:33 -0700 (PDT)
Received: from fedora.mshome.net (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id d128-20020a0df486000000b005925765aa30sm3476327ywf.135.2023.09.19.16.09.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 16:09:33 -0700 (PDT)
From:   Gregory Price <gourry.memverge@gmail.com>
X-Google-Original-From: Gregory Price <gregory.price@memverge.com>
To:     linux-mm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-api@vger.kernel.org, linux-cxl@vger.kernel.org,
        luto@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        arnd@arndb.de, akpm@linux-foundation.org, x86@kernel.org,
        Gregory Price <gregory.price@memverge.com>
Subject: [RFC] man/move_phys_pages: migrate pages based on physical address
Date:   Tue, 19 Sep 2023 19:09:09 -0400
Message-Id: <20230919230909.530174-7-gregory.price@memverge.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230919230909.530174-1-gregory.price@memverge.com>
References: <20230919230909.530174-1-gregory.price@memverge.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Draft of the move_phys_pages syscall proposed in RFC:

https://lore.kernel.org/all/20230907075453.350554-1-gregory.price@memverge.com/

Signed-off-by: Gregory Price <gregory.price@memverge.com>
---
 man2/move_phys_pages.2 | 180 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 180 insertions(+)
 create mode 100644 man2/move_phys_pages.2

diff --git a/man2/move_phys_pages.2 b/man2/move_phys_pages.2
new file mode 100644
index 000000000..4f4b68915
--- /dev/null
+++ b/man2/move_phys_pages.2
@@ -0,0 +1,180 @@
+.\" SPDX-License-Identifier: Linux-man-pages-copyleft-2-para
+.\"
+.\" This manpage is Copyright (C) 2006 Silicon Graphics, Inc.
+.\"                               Christoph Lameter
+.\" This manpage is Copyright (C) 2023 MemVerge, Inc.
+.\"                               Gregory Price
+.\"
+.\"
+.TH move_phys_pages 2 (date) "Linux man-pages (unreleased)"
+.SH NAME
+move_phys_pages \- move individual physically-addressed pages to another node
+.SH LIBRARY
+NUMA (Non-Uniform Memory Access) policy library
+.RI ( libnuma ", " \-lnuma )
+.SH SYNOPSIS
+.nf
+.B #include <numaif.h>
+.PP
+.BI "long move_phys_pages(unsigned long " count ", \
+uint64_t *" pages [. count ],
+.BI "                const int " nodes [. count "], int " status [. count "], \
+int " flags );
+.fi
+.SH DESCRIPTION
+.BR move_phys_pages ()
+moves the specified
+.I physical pages
+to the memory nodes specified by
+.IR nodes .
+The result of the move is reflected in
+.IR status .
+The
+.I flags
+indicate constraints on the pages to be moved.
+.PP
+This interface requires
+.RB ( CAP_SYS_ADMIN ) .
+.PP
+.I count
+is the number of pages to move.
+It defines the size of the three arrays
+.IR pages ,
+.IR nodes ,
+and
+.IR status .
+.PP
+.I pages
+is an array of physical addresses to the pages that should be moved.
+These are addresses that should be aligned to page boundaries.
+.PP
+.I nodes
+is an array of integers that specify the desired location for each page.
+Each element in the array is a node number.
+.I nodes
+can also be NULL, in which case
+.BR move_phys_pages ()
+does not move any pages but instead will return the node
+where each page currently resides, in the
+.I status
+array.
+Obtaining the status of each page may be necessary to determine
+pages that need to be moved.
+.PP
+.I status
+is an array of integers that return the status of each page.
+The array contains valid values only if
+.BR move_phys_pages ()
+did not return an error.
+Preinitialization of the array to a value
+which cannot represent a real numa node or valid error of status array
+could help to identify pages that have been migrated if a partial
+failure occurs.
+.PP
+.I flags
+specify what types of pages to move.
+.B MPOL_MF_MOVE
+means that only pages that are in exclusive use by a process
+are to be moved.
+.B MPOL_MF_MOVE_ALL
+means that pages shared between multiple processes can also be moved.
+.SS Page states in the status array
+The following values can be returned in each element of the
+.I status
+array.
+.TP
+.B 0..MAX_NUMNODES
+Identifies the node on which the page resides.
+.TP
+.B \-EACCES
+The target node for the page is not in the insectional set of allowed
+nodes defined by all tasks mapping the address. At least one task
+mapping the address does not allow memory the target node.
+.TP
+.B \-EBUSY
+The page is currently busy and cannot be moved.
+Try again later.
+This occurs if a page is undergoing I/O or another kernel subsystem
+is holding a reference to the page.
+.TP
+.B \-EFAULT
+This is a zero page, the memory area is not mapped by the process,
+or the memory is not migratable.
+.TP
+.B \-EIO
+Unable to write back a page.
+The page has to be written back
+in order to move it since the page is dirty and the filesystem
+does not provide a migration function that would allow the move
+of dirty pages.
+.TP
+.B \-EINVAL
+A dirty page cannot be moved.
+The filesystem does not
+provide a migration function and has no ability to write back pages.
+
+.TP
+.B \-ENOENT
+The physical page is not online or the page is not present in any VMA.
+.TP
+.B \-ENOMEM
+Unable to allocate memory on target node.
+.SH RETURN VALUE
+On success
+.BR move_phys_pages ()
+returns zero.
+.\" FIXME . Is the following quite true: does the wrapper in numactl
+.\" do the right thing?
+On error, it returns \-1, and sets
+.I errno
+to indicate the error.
+If positive value is returned, it is the number of
+nonmigrated pages.
+.SH ERRORS
+.TP
+.B Positive value
+The number of nonmigrated pages if they were the result of nonfatal
+reasons.
+.TP
+.B EFAULT
+Parameter array could not be accessed.
+.TP
+.B EINVAL
+The flag value was not 0 (Linux 6.6), or an attempt was made to
+migrate pages of a kernel thread.
+.TP
+.B ENODEV
+One of the target nodes is not online.
+.TP
+.B EPERM
+The caller specified has insufficient privileges
+.RB ( CAP_SYS_ADMIN ).
+.SH STANDARDS
+Linux.
+.SH HISTORY
+Linux X.Y.Z
+.SH NOTES
+For information on library support, see
+.BR numa (7).
+.PP
+Use of this function may result in pages whose location
+(node) violates the memory policy established for the
+specified addresses (See
+.BR mbind (2))
+and/or the specified process (See
+.BR set_mempolicy (2)).
+That is, memory policy does not constrain the destination
+nodes used by
+.BR move_phys_pages ().
+.PP
+The
+.I <numaif.h>
+header is not included with glibc, but requires installing
+.I libnuma\-devel
+or a similar package.
+.SH SEE ALSO
+.BR mbind (2),
+.BR numa (3),
+.BR numa_maps (5),
+.BR cpuset (7),
+.BR numa (7),
+.BR migratepages (8),
+.BR numastat (8)
-- 
2.34.1

