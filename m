Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37144798ACA
	for <lists+linux-arch@lfdr.de>; Fri,  8 Sep 2023 18:44:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245088AbjIHQoi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 8 Sep 2023 12:44:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbjIHQoh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 8 Sep 2023 12:44:37 -0400
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com [IPv6:2607:f8b0:4864:20::b43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EAF11FCD;
        Fri,  8 Sep 2023 09:44:32 -0700 (PDT)
Received: by mail-yb1-xb43.google.com with SMTP id 3f1490d57ef6-d77ad095e5cso2143834276.0;
        Fri, 08 Sep 2023 09:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694191471; x=1694796271; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bUkqZvZbz4Nyum4FhbznSqFgacq2OtzkInkEQPk5/xc=;
        b=YzSOCxTo31JYuYMVP+FoJ+6yxsizZKxcLIZYNsn0irI2NUqHNW9WK1ZLeQCqb5sAkY
         Q6htI6E+iyG7Uepy26lAmDMHiViPatoSJmVa/c5zE4vtraX+Zy0fWTCxgNP1j9MkoaZW
         rpMVP6xQB3xOVDrL9PgOMoJiP7ST59NyLFbX6Q1P2vNG++pnOs5GjshL9korBuKEDpLL
         0pK3jtP6XIK0GGKAQcV8MbnaiP9fJWAEBkGr9668s8mG7Qy4B6CzLf6ozD1iwDiu6Vj5
         YmS1B6F5ypxXBjuLisHo8yIVHRti9EcdV12fprDuXecpCpfPzSeSJ8GPrTgUopLOE17h
         0dww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694191471; x=1694796271;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bUkqZvZbz4Nyum4FhbznSqFgacq2OtzkInkEQPk5/xc=;
        b=TnNq0WX9nnSGgeQy5ygZ/wewkygSSIENyYkinPZ9SfTXWORetOOwKpAKzJOI7Vhb38
         Jd8oR/Zq/zrMdnFn/dC9Y3fTi3UykMFhhUJ/5M34t8VYJ52Le3Nf7PAC8qnuV8JnF05C
         el+n5eoWhkCYM8nOO1KPhUZY4yPw3kufR8P71fxV68NEKyBlwoR3+PAO6k1tcs0QNA2q
         kshWEUxG3ikuSDVG1vaItZ71t52x6yf0H9s3eOzYirfpmLkUvY2nmLg9J9RDbAmyzP8/
         lp+/fVSfAqWH5pmfgXIoWETvyRBigA5aSz1NsBs4bnU64Eon959NjDpRnUr4amN+qaJf
         PK6Q==
X-Gm-Message-State: AOJu0YzS9TDAT1qY24u7MUaXI1RGBDMw9DxcYPFfFsBL4IHpBMKWXGbj
        Y9G4Hn7wZRKKOeKGkdmqEPGfdHiQDfUy
X-Google-Smtp-Source: AGHT+IGrVeZTh3E5MKjaW2y+sPxVfcM3PbpLtCrVCbcst+i27PQrLgQ8Ovu/RBw6NTpzGx2iXE1n0A==
X-Received: by 2002:a25:3414:0:b0:d77:de72:592b with SMTP id b20-20020a253414000000b00d77de72592bmr2517119yba.48.1694191471587;
        Fri, 08 Sep 2023 09:44:31 -0700 (PDT)
Received: from fedora.mshome.net (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id e66-20020a253745000000b00d7ba7de90casm438858yba.51.2023.09.08.09.44.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Sep 2023 09:44:31 -0700 (PDT)
From:   Gregory Price <gourry.memverge@gmail.com>
X-Google-Original-From: Gregory Price <gregory.price@memverge.com>
To:     linux-mm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-api@vger.kernel.org, linux-cxl@vger.kernel.org,
        luto@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        arnd@arndb.de, akpm@linux-foundation.org, x86@kernel.org,
        Gregory Price <gregory.price@memverge.com>
Subject: [RFC 0/3] sys_move_phy_pages system call
Date:   Thu,  7 Sep 2023 03:54:50 -0400
Message-Id: <20230907075453.350554-1-gregory.price@memverge.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DATE_IN_PAST_24_48,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This patch set is a proposal for a syscall analogous to move_pages,
that migrates pages between NUMA nodes using physical addressing.

The intent is to better enable user-land system-wide memory tiering
as CXL devices begin to provide memory resources on the PCIe bus.

This patch set broken into 3 patches:
  1 & 2) A small refactor of existing migration code for the purpose
         of reusing that code
  3) The sys_move_phys_pages system call.

The sys_move_phys_pages system call validates the page may be
migrated by checking migratable-status of each vma mapping the page,
and the intersection of cpuset policies each vma's task.


Background:

Userspace job schedulers, memory managers, and tiering software
solutions depend on page migration syscalls to reallocate resources
across NUMA nodes. Currently, these calls enable movement of memory
associated with a specific PID. Moves can be requested in coarse,
process-sized strokes (as with migrate_pages), and on specific virtual
pages (via move_pages).

However, a number of profiling mechanisms provide system-wide information
that would benefit from a physical-addressing version move_pages.
  - the IDLE bit is cleared on reads/writes of physical pages
  - /proc/zoneinfo breaks PFN-space into NUMA nodes
  - PEBS/IBS can track frequency of accesses to physical addresses.
  - Devices themselves may provide hotness information about its memory
    resources, either with physical or device addressing.

Information from these sources facilitates systemwide resource management,
but with the limitations of migrate_pages and move_pages applying to
individual tasks, their outputs must be converted back to virtual addresses
and re-associated with specific PIDs.

Doing this reverse-translation outside of the kernel requires considerable
space and compute, and it will have to be performed again by the existing
system calls.  Much of this work can be avoided if the pages can be
migrated directly with physical memory addressing.

Gregory Price (3):
  mm/migrate: remove unused mm argument from do_move_pages_to_node
  mm/migrate: refactor add_page_for_migration for code re-use
  mm/migrate: Create move_phys_pages syscall

 arch/x86/entry/syscalls/syscall_32.tbl  |   1 +
 arch/x86/entry/syscalls/syscall_64.tbl  |   1 +
 include/linux/syscalls.h                |   5 +
 include/uapi/asm-generic/unistd.h       |   8 +-
 kernel/sys_ni.c                         |   1 +
 mm/migrate.c                            | 268 ++++++++++++++++++++----
 tools/include/uapi/asm-generic/unistd.h |   8 +-
 7 files changed, 248 insertions(+), 44 deletions(-)

-- 
2.39.1

