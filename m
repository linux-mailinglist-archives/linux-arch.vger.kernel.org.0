Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CCD57A1208
	for <lists+linux-arch@lfdr.de>; Fri, 15 Sep 2023 01:55:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230196AbjINXzG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 14 Sep 2023 19:55:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjINXzG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 14 Sep 2023 19:55:06 -0400
Received: from mail-yw1-x1142.google.com (mail-yw1-x1142.google.com [IPv6:2607:f8b0:4864:20::1142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC1B62100;
        Thu, 14 Sep 2023 16:55:01 -0700 (PDT)
Received: by mail-yw1-x1142.google.com with SMTP id 00721157ae682-58dfe2d5b9aso22159847b3.1;
        Thu, 14 Sep 2023 16:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694735701; x=1695340501; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7qepxbzS5XdPD9xh3SwraLNxpPnShl/gUW6LA9HJxzw=;
        b=ebfuDueMFHxSoIFDAOfrmrqR66OQKyRMDBOcJReddIyXMlA4erzvqQ9i0RKBTOPonD
         Edmq7rpQEjEN+Fpw8++gz4nL23kb+Ixo4Ii0wANlGM4pVx1sgROKBtY3QDbf5E3L1oPa
         ARQJh85ZzkfFsRG8uS7efh71WQWweFW5scx6WT629WXPBVRAt5JUeWeW1lt+MJglD4hA
         5zFCrsVtJiuBfcN9NuTvlrRgHQ4I5n/dKAn1o9cdxPkcjjkC7SCBtMb3/lsxgtMGaJ+6
         Zf2wVIng2pnlsZgyIOyskTi5NBsAxmIstfHJR+Fgcoz5RUGG/2/qQGhCFHeSyg/5K/Ug
         OjAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694735701; x=1695340501;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7qepxbzS5XdPD9xh3SwraLNxpPnShl/gUW6LA9HJxzw=;
        b=XDsfqM4afX5bNk76FnCYrEhnnSZUVibaflg+JAPEg4zb83GA1gdjCAFdGwyzUlnRQ1
         aXqckyNlz78oZJa2l+Nr33br56M6Ac7Zz98Ei+bRNTc0yE5EndQH/HyOfEVezUnmMcse
         KHaIlU3+9zAIsbDO8xSo4vspzsCvn4c7KNd7XCejKZR0P1uuuNTvgt9shLamfvkWXGDE
         2zu8z5hywXXP33SwFQlCqBgyB7dZXs0gVKILz5R9hID5myf8P5+i2VyGrq/cMlspqmm+
         MhTQSO03IoTsimitCsYjuYWGemB5vU8EL4SXiSckexyLnXt7rFPqTut7YOkN6xr3QofY
         frEw==
X-Gm-Message-State: AOJu0YwTNidHDzfZfSBJZ8YQh4NynXoEpbck2XL13Bzorcitzz5akFUf
        9stxouEPDt1TxNlF4zKvHq9PmxrHujEs
X-Google-Smtp-Source: AGHT+IHFKkZVg1gZ7tlOPnP8R4Axfb1O5oFaflDfUS6HtaIhw+51ycjeiejirTGNzEgqLpH9GIxMPw==
X-Received: by 2002:a0d:db94:0:b0:59b:b9fe:1838 with SMTP id d142-20020a0ddb94000000b0059bb9fe1838mr171547ywe.1.1694735700851;
        Thu, 14 Sep 2023 16:55:00 -0700 (PDT)
Received: from fedora.mshome.net (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id p188-20020a0dcdc5000000b005777a2c356asm586300ywd.65.2023.09.14.16.54.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 16:55:00 -0700 (PDT)
From:   Gregory Price <gourry.memverge@gmail.com>
X-Google-Original-From: Gregory Price <gregory.price@memverge.com>
To:     linux-mm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-api@vger.kernel.org, linux-cxl@vger.kernel.org,
        luto@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        arnd@arndb.de, akpm@linux-foundation.org, x86@kernel.org,
        Gregory Price <gregory.price@memverge.com>
Subject: [RFC PATCH 0/3] mm/mempolicy: set/get_mempolicy2
Date:   Thu, 14 Sep 2023 19:54:54 -0400
Message-Id: <20230914235457.482710-1-gregory.price@memverge.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This patch set is a proposal for set_mempolicy2 and get_mempolicy2
system calls.  This is an extension to the existing mempolicy
syscalls that allow for a more extensible  mempolicy interface and
new, complex memory policies.

This RFC is broken into 3 patches for discussion:

  1) A refactor of do_set_mempolicy that allows code reuse for
     the new syscalls and centralizes the mempolicy swap code.

  2) The implementation of get_mempolicy2 and set_mempolicy2 which
     includes a new uapi type: "struct mempolicy_args" and denotes
     the original mempolicies as "legacy". This allows the existing
     policies to be routed through the original interface.

     (note: only implemented on x86 at this time, though can be
      hacked into other architectures somewhat trivially)

  3) The implementation of a sample mempolicy ("partial-interleave")
     which was not possible on the old interface.

  x) next planned patches: selftest/ltp test/example programs/etc.
     I wanted to start discussion before i went too deep.


Besides the obvious proposal of extending the mempolicy subsystem for
new policies, the core proposal is the addition of the new uapi type
"struct mempolicy". In this proposal, the get and set interfaces use
the same structure, and some fields may be ignored depending on the
requested operation.

This sample implementation of get_mempolicy allows for the retrieval
of all information that would have previously required multiple calls
to get_mempolicy, and implements an area for per-policy information.

The multiple err fields would allow for continuation of information
retrieval should one or more failures occur (though notably this is
probably not defensible, and should probably just error out - mostly
a debugging interface for now).

This allows for future extensibility, and would avoid the need for
additional syscalls into the future, so long as the args structure
is versioned or checked based on size.

struct mempolicy_args {
  int err;
  unsigned short mode;
  unsigned long *nodemask;
  unsigned long maxnode;
  unsigned short flags;
  struct {
    /* Memory allowed */
    struct {
      int err;
      unsigned long maxnode;
      unsigned long *nodemask;
    } allowed;
    /* Address information */
    struct {
      int err;
      unsigned long addr;
      unsigned long node;
      unsigned short mode;
      unsigned short flags;
    } addr;
  } get;
  union {
    /* Interleave */
    struct {
    unsigned long next_node; /* get only */
    } interleave;
    /* Partial Interleave */
    struct {
      unsigned long interval;  /* get and set */
      unsigned long next_node; /* get only */
    } part_int;
  };
};

In the third patch, we implement a sample Partial-Interleave
mempolicy that is not possible to implement given the existing
mempolicy interface - and would either require the exposure of
new interfaces to set the value described.

We extend the internal mempolicy structure to include to include
a new union area which can be used to host complex policy data.

Example:
union {
  /* Partial Interleave: Allocate local count, then interleave */
  struct {
    int interval; /* allocation interval at which to  interleave */
    int count; /* the current allocation count */
  } part_int;
};


Summary of Partial Interleave:
=============================
nodeset=0,1,2
interval=3
cpunode=0

The preferred node (cpunode) is taken by default to be the node on
which [interval] allocations are made before an interleave occurs.

Over 10 consecutive allocations, the following nodes will be selected:
[0,0,0,1,2,0,0,0,1,2]

In this example, there is a 60%/20%/20% distribution of memory across
the node set.


Some notes for discussion
=========================
0) Why?

  In the coming age of CXL and a many-numa-node system with memory
  hosted on the PCIe bus, new memory policies are likely to be
  beneficial to experiment with and ultimately implement new
  allocation-time placement policies.

  Presently, much focus is placed on memory-usage monitoring and data
  migration, but these methods steal performance to accomplish what
  could be optimized for up-front.  For example, if maximum memory
  bandwidth is required for an operation, then a statistical
  distribution of memory can be calculated fairly easily based on
  approximate expected memory usage.

  Getting a fair approximation of distribution at allocation can help
  reduce the migration load required after-the fact.  This is the
  intent of the included partial-interleave example, which allows for
  an approximate distribution of memory, where the local node is still
  the preferred location for the majority of memory.

1) Maybe this should be a set of sysfs interfaces?

  This would involve adding a /proc/pid/mempolicy interface that
  allows for external processes to interrogate and change the
  mempolicy of running processes. This would be a fundamental
  change to the mempolicy subsystem, as (so far as i can tell)
  this is not possible as of present.

  Additionally, the policy is per-thread, not per-pid. Making this
  work on a per-thread, so it would be /proc/pid/task/tid/mempolicy.

  I avoided that for this RFC as it seemed more radical than simply
  proposing a set/get_mempolicy2 interface.  Though technically it
  could be done.

2) Do we need this level extensibility?

   Presently the ability to dictate allocation-time placement is
   limited to a few primitive mechanisms:
     1) existing mempolicy, and those that can be implemented using
        the existing interface.
     2) numa-aware applications, requiring code changes.
     3) LDPRELOAD methods, which have compability issues.

   For the sake of compatibility, being able to extent numactl to
   include newer, more complex policies would be beneficial.

   While partial-interleave passes a simple interval as an interger,
   more complex policies may want to pass multiple, complex pieces of
   data. For example, a 'statistical-interleave' policy may pass a
   list of integers that dictates exactly how many allocations should
   happen per-node during interleave.  Another policy may take in one
   or more nodemask's and do more complex distributions.


Gregory Price (3):
  mm/mempolicy: refactor do_set_mempolicy for code re-use
  mm/mempolicy: Implement set_mempolicy2 and get_mempolicy2 syscalls
  mm/mempolicy: implement a partial-interleave mempolicy

 arch/x86/entry/syscalls/syscall_32.tbl |   2 +
 arch/x86/entry/syscalls/syscall_64.tbl |   2 +
 include/linux/mempolicy.h              |   8 +
 include/linux/syscalls.h               |   2 +
 include/uapi/asm-generic/unistd.h      |  10 +-
 include/uapi/linux/mempolicy.h         |  37 +++
 mm/mempolicy.c                         | 420 +++++++++++++++++++++++--
 7 files changed, 456 insertions(+), 25 deletions(-)

-- 
2.39.1

