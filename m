Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 147767B5E17
	for <lists+linux-arch@lfdr.de>; Tue,  3 Oct 2023 02:22:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237660AbjJCAWG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 2 Oct 2023 20:22:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237389AbjJCAWF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 2 Oct 2023 20:22:05 -0400
Received: from mail-oa1-x42.google.com (mail-oa1-x42.google.com [IPv6:2001:4860:4864:20::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62476CC;
        Mon,  2 Oct 2023 17:22:01 -0700 (PDT)
Received: by mail-oa1-x42.google.com with SMTP id 586e51a60fabf-1e10507a4d6so231119fac.1;
        Mon, 02 Oct 2023 17:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696292520; x=1696897320; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uuhPUh0uYTyOtat+cBWc3JztI8sfqvFBPjb/Wb5+EC8=;
        b=fdUiXtcLgHTCkMfgG6o1fH/aOqBaW9ekZn29KOxI7SEKPMJ0fClilEQmuhhiMvzwAJ
         f+ZnrUuigaBYPPweclMPqTTuwuTZIGwz/jwTWm6X8dQwDNo6Z9XhwjaY3KN5InWIp/xm
         fRZgzVkC3WWngEwM2Alx1j57rEhYL2SftGpOlZRu8IfXSNtGd+ixUOHvL0BSv0vtT9AC
         BowkMxzh3EFsyS/UhxPtko0oDFRoCEX8HIqPvN2M0YAVceFjsnpCT2+bVIlEJDRV23nE
         ORfqYmzP/GA1lDKiSMpYWFxGiLwuKD5ODqfuKrFF9Uvesbhf/daHkvLVO1Qh4/1lea1X
         7m6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696292520; x=1696897320;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uuhPUh0uYTyOtat+cBWc3JztI8sfqvFBPjb/Wb5+EC8=;
        b=RZN+pM2iCmpcF/X/psWZuptqU3L/PTHVN9eNW8oBVQco2eREU7iu6wsl1I0dlEZcYc
         DXwQPUwHjh2obDY7YbdlqaKEOQx/sCHNEhVPALFuVT8SEmUvZzwerla1QMT7umKT/c7T
         tnCdm8M2Y9nxBlg6sthDb8wUQhjYLWLr6tiy+hQAP0WvYPq077L/ErEuLT4ABqPXQ0Yn
         04UfxEyI+bqdxGXVuOLiNLpLaQNN54lf+2iFDUJ86K6TGlZKddlBEc1pX+YoAL3pXjIw
         pPSk5+/kzVoQwsi44IJZeqYBWGUITkbvABUxfByU3zi3SuTXygKtgvPVDbKdKK6B/uip
         2ERg==
X-Gm-Message-State: AOJu0YxREZgZDUuLTMDwQ54mxvna6HMZzvQNUPkEYi647dTwZOTmLgyB
        O6N5AwtYDYAlanw2OLdavw==
X-Google-Smtp-Source: AGHT+IEMaNvc9GighnWe6s22nYSLEFHD8PQ/7QhG0rtWyDaV7W+KjHXahywEecOySrP+ampgoMdJCQ==
X-Received: by 2002:a05:6871:b0d:b0:1dc:f4de:46b8 with SMTP id fq13-20020a0568710b0d00b001dcf4de46b8mr15896518oab.59.1696292520502;
        Mon, 02 Oct 2023 17:22:00 -0700 (PDT)
Received: from fedora.mshome.net (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id a2-20020a056870618200b001e135f4f849sm24725oah.9.2023.10.02.17.21.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 17:22:00 -0700 (PDT)
From:   Gregory Price <gourry.memverge@gmail.com>
X-Google-Original-From: Gregory Price <gregory.price@memverge.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-api@vger.kernel.org, linux-cxl@vger.kernel.org,
        luto@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        arnd@arndb.de, akpm@linux-foundation.org, x86@kernel.org,
        Gregory Price <gregory.price@memverge.com>
Subject: [RFC PATCH v2 0/4] mm/mempolicy: get/set_mempolicy2 syscalls
Date:   Mon,  2 Oct 2023 20:21:52 -0400
Message-Id: <20231003002156.740595-1-gregory.price@memverge.com>
X-Mailer: git-send-email 2.39.1
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

v2: style updates, weighted-interleave, rename partial-interleave to
    preferred-interleave, variety of bug fixes.

---

This patch set is a proposal for set_mempolicy2 and get_mempolicy2
system calls.  This is an extension to the existing mempolicy
syscalls that allow for a more extensible mempolicy interface and
new, complex memory policies.

This RFC is broken into 4 patches for discussion:

  1) A refactor of do_set_mempolicy that allows code reuse for
     the new syscalls when replacing the task mempolicy.

  2) The implementation of get_mempolicy2 and set_mempolicy2 which
     includes a new uapi type: "struct mempolicy_args" and denotes
     the original mempolicies as "legacy". This allows the existing
     policies to be routed through the original interface.

     (note: only implemented on x86 at this time, though can be
      hacked into other architectures somewhat trivially)

  3) The implementation of "preferred-interleave", a policy which
     applies a weight to the local node while interleaving.

  4) The implementation of "weighted-interleave", a policy which
     applies weights to all enabled nodes while interleaving.

  x) Future Updates: ktest, numactl, and man page updates


Besides the obvious proposal of extending the mempolicy subsystem for
new policies, the core proposal is the addition of the new uapi type
"struct mempolicy". In this proposal, the get and set interfaces use
the same structure, and some fields may be ignored depending on the
requested operation.

This sample implementation of get_mempolicy allows for the retrieval
of all information that would have previously required multiple calls
to get_mempolicy, and implements an area for per-policy information.

This allows for future extensibility, and would avoid the need for
additional syscalls in the future.

struct mempolicy_args {
  unsigned short mode;
  unsigned long *nodemask;
  unsigned long maxnode;
  unsigned short flags;
  struct {
        /* Memory allowed */
        struct {
                unsigned long maxnode;
                unsigned long *nodemask;
        } allowed;
        /* Address information */
        struct {
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
    /* Preferred Interleave */
    struct {
      unsigned long weight;  /* get and set */
      unsigned long next_node; /* get only */
    } pil;
    /* Weighted Interleave */
    struct {
      unsigned long next_node; /* get only */
      unsigned char *weight; /* get and set */
    } wil;
  };
};

In the third and fourth patch, we implement preferred and weighted
interleave policies (respectively), which could not be implemented
with the existing syscalls.

We extend the internal mempolicy structure to include to include
a new union area which can be used to host complex policy data.

Example:
union {
  /* Preferred Interleave: Allocate local count, then interleave */
  struct {
    int weight;
    int count;
  } pil;
  /* Weighted Interleave */
  struct {
    unsigned int il_weight;
    unsigned char cur_weight;
    unsigned char weights[MAX_NUMNODES];
  } wil;
};


Summary of Preferred Interleave:
================================
nodeset=0,1,2
interval=3
cpunode=0

The preferred node (cpunode) is the "preferred" node on which [weight]
allocations are made before an interleave occurs.

Over 10 consecutive allocations, the following nodes will be selected:
[0,0,0,1,2,0,0,0,1,2]

In this example, there is a 60%/20%/20% distribution of memory across
the node set.

This is a useful strategy if the goal is an even distribution of
memory across all non-local nodes for the purpose of bandwidth AND
task-node migrations are a possibility.  In this case, the weight
applies to whatever the local node happens to be at the time of the
interleave, rather than a static node weight.


Summary of Weighted Interleave:
===============================

The weighted-interleave mempolicy implements weights per-node
which are used to distribute memory while interleaving.

For example:
nodes: 0,1,2
weights: 5,3,2

Over 10 consecutive allocations, the following nodes will be selected:
[0,0,0,0,0,1,1,1,2,2]

If a node is enabled, the minimum weight is 1. If an enabled node
ends up with a weight of 0 (cgroup updates can cause a runtime
recalculation) a minimum of 1 is applied during interleave.

This is a useful strategy if the goal is a non-even distribution of
memory across a variety of nodes AND task-node migrations are NOT
expected to occur (or the weights are approximately the same,
relationally from all possible target nodes).

This is because "Thread A" with weights set for best performance
from the perspective of "Socket 0" may have a less-than-optimal
interleave strategy if "Thread A" is migrated to "Socket 1". In
this scenario, the bandwidth and latency attributes of each node
will have changed, as will the local node.

In the above example, a thread migrating from node 0 to node 1 will
cause most of its memory to be allocated on remote nodes, which is
less than optimal.


Some notes for discussion
=========================
0) Why?

  In the coming age of CXL and a many-numa-node system with memory
  hosted on the PCIe bus, new memory policies are likely to be
  beneficial to experiment with and ultimately implement new
  allocation-time placement policies.

  Presently, much focus is placed on memory-usage monitoring and data
  migration, but these methods steal performance to accomplish what
  could be optimized for up-front.  For example, if maximizing bandwith
  is preferable, then a statistical distribution of memory can be
  calculated fairly easily based on task location..

  Getting a fair approximation of distribution at allocation can help
  reduce the migration load required after-the fact.  This is the
  intent of the included preferred-interleave example, which allows for
  an approximate distribution of memory, where the local node is still
  the preferred location for the majority of memory.

1) Maybe this should be a set of sysfs interfaces?

  This would involve adding a /proc/pid/mempolicy interface that
  allows for external processes to interrogate and change the
  mempolicy of running processes. This would be a fundamental
  change to the mempolicy subsystem.

  I attempted this, but eventually came to the conclusion that it
  would require a much more radical re-write of mempolicy.c code
  due concurrency issues.

  Notably, mempolicy.c is very "current"--centric, and is not well
  designed for runtime changes to nodemask (and, subsequently, the
  new weights added to struct mempolicy).

  I avoided that for this RFC as it seemed far more radical than
  proposing a set/get_mempolicy2 interface.  Though technically it
  could be done.

2) Why not do this in cgroups or memtier?

  Both have the issue of functionally being a "global" setting,
  in the sense that cgroups/memtier implemented weights would
  produce poor results on processes whose threads span multiple
  sockets (or on a thread migration).

  Consider the following scenario:

  Node 0 - Socket 0 DRAM
  Node 1 - Socket 1 DRAM
  Node 2 - Socket 0 local CXL
  Node 3 - Socket 1 local CXL
  Weights:
    [0:4, 1:2, 2:2, 3:1]

  The "Tiers" in this case are essentially [0, 1-2, 3]

  We have 2 tasks in our cgroup:
  Thread A - socket 0
  Thread B - socket 1

  In this scenario, Thread B will have a very poor distribution of
  memory, with most of its memory landing on a remote-socket.

  Instead, it's preferable for workloads to stick to a single socket
  where possible, and future work will need to be done to determine
  how to handle workloads which span sockets.  Due to the above
  mentioned issues with concurrency, this may be quite some time.

  In the meantime, there is user for weights to be carried per-task.

  For migrations:

  Weights could be recalculated based on the new location of the
  task. This recalculation of weights is not included in this
  patch set, but could be done as an extension to weighted
  interleave, where a thread that detects it has been migrated
  works with memtier.c to adjust its weights internally.

  So basically even if you implement these things in cgroups/memtier,
  you still require per-task information (local node) to adjust the
  weights.  My proposal: Just do it in mempolicy and use things like
  cgroups/memtier to enrich that implementation, rather than the other
  way around.

3) Do we need this level extensibility?

   Presently the ability to dictate allocation-time placement is
   limited to a few primitive mechanisms:

     1) existing mempolicy, and those that can be implemented using
        the existing interface.
     2) numa-aware applications, requiring code changes.
     3) LDPRELOAD methods, which have compability issues.

   For the sake of compatibility, being able to extend numactl to
   include newer, more complex policies would be beneficial.

Gregory Price (4):
  mm/mempolicy: refactor do_set_mempolicy for code re-use
  mm/mempolicy: Implement set_mempolicy2 and get_mempolicy2 syscalls
  mm/mempolicy: implement a preferred-interleave mempolicy
  mm/mempolicy: implement a weighted-interleave mempolicy

 arch/x86/entry/syscalls/syscall_32.tbl |   2 +
 arch/x86/entry/syscalls/syscall_64.tbl |   2 +
 include/linux/mempolicy.h              |  14 +
 include/linux/syscalls.h               |   4 +
 include/uapi/asm-generic/unistd.h      |  10 +-
 include/uapi/linux/mempolicy.h         |  41 ++
 mm/mempolicy.c                         | 688 ++++++++++++++++++++++++-
 7 files changed, 741 insertions(+), 20 deletions(-)

-- 
2.39.1

