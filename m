Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A344791AB4
	for <lists+linux-arch@lfdr.de>; Mon,  4 Sep 2023 17:36:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235162AbjIDPgx (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 4 Sep 2023 11:36:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231127AbjIDPgx (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 4 Sep 2023 11:36:53 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 719D41AD;
        Mon,  4 Sep 2023 08:36:49 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1c328b53aeaso12063295ad.2;
        Mon, 04 Sep 2023 08:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693841809; x=1694446609; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eJMRKLoGq23gtRPR9q2qXbt8GN9myACbt7vkmLrXYk0=;
        b=T+Z5buK3qI62Ezel/IV03I+GeuCVwhpx9/wm0Apfb5LanRMj4B36mbHfj41WWm9T8m
         ogzG2orC7oa9/f0cANe07Eu2oQrE5Q/SRbFOgZGr89Mjii22Rll/ykczEYAGzY6ShK1/
         KM5tiqGWpBCuyk16tGBD+EIjPaetNUqXNwihbpXyfNI8fbm5dmfNF7PvZIUrcajT4Pw8
         R8faouLFoX4cPbWT5gP3lY17gNzwUuoWgKfv4/o6pU/mboEVyTvydMUauK3kr1f4kfbl
         7z3fbYz+H80mZJIDW8ERq6/S10Rb4ga195xbmi2n9RW+3XtAQN0Hr6/oCin2c+Ren+IN
         PQcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693841809; x=1694446609;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eJMRKLoGq23gtRPR9q2qXbt8GN9myACbt7vkmLrXYk0=;
        b=IDKgVIHstNRtOgJJhbEttBiR/0h2IkkWKuHBqAnko0GxFWGnHnOF1jK+CbD/CZaqqQ
         xbQdi3YMA/GsAVUpfLCG7LXWmdT0lU4lN5NvY2Gn6AURzjhZ2sgC5qAheS9K6w146Alh
         1CdJ9J3q67/+0b/t9jFhPl+9YCrVQ9yz/7WMiDJvvnlTIjkm5fJuXPn/Jjx9RrMgHRQ/
         8CjjF2H7AX25bbgt3P1feUvYriIJkw4nTjjp3YewfhBvV9iw88RKbwX5GC8Av9HmA2wd
         6JGU/5d2cze2gifIr7989TDfVcqy065uKrxCPgdSOFroQCc+oIxynM3iLo1b1gS7Ks/6
         hyQQ==
X-Gm-Message-State: AOJu0YxWLJAO7S8oGpJiCzJJHyqBSgOTkfh4jR8+00f/7egb8jwp5u1B
        Jv0KTdGPBGkG/nVkTYij5CM=
X-Google-Smtp-Source: AGHT+IG8hUZHEMU8KkA/JxNWmE1sZHMxEvEfrG1ePwXSrkMt5L0BKT5z3Yqm+sBgA1Is8SAzlfwblw==
X-Received: by 2002:a17:902:d48e:b0:1c0:ce51:8e8d with SMTP id c14-20020a170902d48e00b001c0ce518e8dmr12257913plg.67.1693841806978;
        Mon, 04 Sep 2023 08:36:46 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id f9-20020a17090a638900b00256799877ffsm7529506pjj.47.2023.09.04.08.36.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Sep 2023 08:36:46 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 4 Sep 2023 08:36:44 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Mike Rapoport <rppt@kernel.org>,
        "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org
Subject: Re: [PATCH v6 26/38] sparc64: Implement the new page table range API
Message-ID: <2513a500-920d-4e32-8231-f428175c7182@roeck-us.net>
References: <20230802151406.3735276-1-willy@infradead.org>
 <20230802151406.3735276-27-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230802151406.3735276-27-willy@infradead.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi,

On Wed, Aug 02, 2023 at 04:13:54PM +0100, Matthew Wilcox (Oracle) wrote:
> Add set_ptes(), update_mmu_cache_range(), flush_dcache_folio() and
> flush_icache_pages().  Convert the PG_dcache_dirty flag from being
> per-page to per-folio.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: sparclinux@vger.kernel.org

This patch causes all my sparc64 qemu boot tests to crash.

[    4.890744] Unable to handle kernel NULL pointer dereference
[    4.891273] tsk->{mm,active_mm}->context = 0000000000000001
[    4.891475] tsk->{mm,active_mm}->pgd = fffff80005452000
[    4.891660]               \|/ ____ \|/
[    4.891660]               "@'/ .. \`@"
[    4.891660]               /_| \__/ |_\
[    4.891660]                  \__U_/
[    4.892116] modprobe(45): Oops [#1]
[    4.892555] CPU: 0 PID: 45 Comm: modprobe Tainted: G                 N 6.5.0+ #1
[    4.892949] TSTATE: 0000004411001601 TPC: 00000000004565d8 TNPC: 00000000004565dc Y: 00000008    Tainted: G                 N
[    4.893307] TPC: <tlb_batch_add+0xf8/0x2a0>
[    4.893829] g0: ec3264ae48eeb037 g1: 0000000000000028 g2: 00000000000a010c g3: 0000060000000000
[    4.894103] g4: fffff80004c8c1a0 g5: fffff8001dc2e000 g6: fffff80005440000 g7: fffff8001fe3f700
[    4.894373] o0: fffff80005420008 o1: 000007feffffe000 o2: fffff80005443788 o3: fffff80004c8c1a0
[    4.894642] o4: fffff80004c8cc88 o5: 0000000001a3c000 sp: fffff80005442ee1 ret_pc: 00000000006058c8
[    4.894918] RPC: <__pte_offset_map_lock+0x68/0x120>
[    4.895118] l0: 0000000000605908 l1: 00000000011e8998 l2: 00000000011e8968 l3: fffff80005420008
[    4.895392] l4: 000000000541e000 l5: fffff80005410060 l6: 00000000023c7800 l7: 00000000020fdee8
[    4.895661] i0: fffff80005410020 i1: 000007feffffe000 i2: 0000060000052600 i3: 8000000002931fb2
[    4.895931] i4: 0000000000000000 i5: 000000000000000d i6: fffff80005442f91 i7: 0000000000601718
[    4.896204] I7: <change_protection+0x678/0x9e0>
[    4.896403] Call Trace:
[    4.896567] [<0000000000601718>] change_protection+0x678/0x9e0
[    4.896807] [<0000000000601b80>] mprotect_fixup+0x100/0x2e0
[    4.896990] [<0000000000652050>] setup_arg_pages+0x130/0x2a0
[    4.897172] [<00000000006ba758>] load_elf_binary+0x358/0x13c0
[    4.897367] [<0000000000652a00>] bprm_execve+0x2e0/0x8e0
[    4.897540] [<0000000000653e24>] kernel_execve+0x144/0x200
[    4.898023] [<000000000048775c>] call_usermodehelper_exec_async+0xbc/0x140
[    4.898248] [<00000000004060e8>] ret_from_fork+0x1c/0x2c
[    4.898422] [<0000000000000000>] 0x0
[    4.898641] Disabling lock debugging due to kernel taint
[    4.898860] Caller[0000000000601718]: change_protection+0x678/0x9e0
[    4.899073] Caller[0000000000601b80]: mprotect_fixup+0x100/0x2e0
[    4.899254] Caller[0000000000652050]: setup_arg_pages+0x130/0x2a0
[    4.899435] Caller[00000000006ba758]: load_elf_binary+0x358/0x13c0
[    4.899618] Caller[0000000000652a00]: bprm_execve+0x2e0/0x8e0
[    4.899789] Caller[0000000000653e24]: kernel_execve+0x144/0x200
[    4.899964] Caller[000000000048775c]: call_usermodehelper_exec_async+0xbc/0x140
[    4.900177] Caller[00000000004060e8]: ret_from_fork+0x1c/0x2c
[    4.900349] Caller[0000000000000000]: 0x0
[    4.900487] Instruction DUMP:
[    4.900517]  80886001
[    4.900714]  126fffca
[    4.900797]  01000000
[    4.900876] <c2582000>
[    4.900954]  83307013
[    4.901032]  80886001
[    4.901109]  02680007
[    4.901187]  01000000
[    4.901269]  c2582000
[    4.901353]
[    4.901535] note: modprobe[45] exited with preempt_count 2

Bisect log attached.

Guenter

---
# bad: [708283abf896dd4853e673cc8cba70acaf9bf4ea] Merge tag 'dmaengine-6.6-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine
# good: [2dde18cd1d8fac735875f2e4987f11817cc0bc2c] Linux 6.5
git bisect start 'HEAD' 'v6.5'
# bad: [53ea7f624fb91074c2f9458832ed74975ee5d64c] Merge tag 'xfs-6.6-merge-1' of git://git.kernel.org/pub/scm/fs/xfs/xfs-linux
git bisect bad 53ea7f624fb91074c2f9458832ed74975ee5d64c
# good: [c873512ef3a39cc1a605b7a5ff2ad0a33d619aa8] Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
git bisect good c873512ef3a39cc1a605b7a5ff2ad0a33d619aa8
# good: [3b6bf5b1f8e3d17d7566027cdc5a8262991eb5bc] Merge tag 'spi-v6.6' of git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi
git bisect good 3b6bf5b1f8e3d17d7566027cdc5a8262991eb5bc
# bad: [b96a3e9142fdf346b05b20e867b4f0dfca119e96] Merge tag 'mm-stable-2023-08-28-18-26' of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
git bisect bad b96a3e9142fdf346b05b20e867b4f0dfca119e96
# bad: [bb7dbaafff3f582d18028a5b99a8faa789842678] mm: remove checks for pte_index
git bisect bad bb7dbaafff3f582d18028a5b99a8faa789842678
# good: [601f006fddc66e369fdac7c572f981eafd159dac] powerpc/book3s64/radix: remove mmu_vmemmap_psize
git bisect good 601f006fddc66e369fdac7c572f981eafd159dac
# good: [7e5f42ae3413785c68c383acb787f9ce8f243096] mm: convert pmd_ptlock_free() to use ptdescs
git bisect good 7e5f42ae3413785c68c383acb787f9ce8f243096
# good: [a644b0abbfe1d7cf775082cafdcc7b5f3c35becf] mm: convert split_huge_pages_pid() to use a folio
git bisect good a644b0abbfe1d7cf775082cafdcc7b5f3c35becf
# good: [994209410919f2b84b7e4ab2e78785d9715308ad] nios2: implement the new page table range API
git bisect good 994209410919f2b84b7e4ab2e78785d9715308ad
# bad: [9f1f5b60e76d44fa85fef6970b7477f72d3999eb] mm: use flush_icache_pages() in do_set_pmd()
git bisect bad 9f1f5b60e76d44fa85fef6970b7477f72d3999eb
# good: [665f640294540a941aabb81ae46dfc671aff5259] sparc32: implement the new page table range API
git bisect good 665f640294540a941aabb81ae46dfc671aff5259
# bad: [4fbb7e7f47dbc631a9f5bad3171ccbca171ed1d3] xtensa: implement the new page table range API
git bisect bad 4fbb7e7f47dbc631a9f5bad3171ccbca171ed1d3
# bad: [fd8132e6e9fdecb9ff7d1db98014d372e03f3c9d] um: implement the new page table range API
git bisect bad fd8132e6e9fdecb9ff7d1db98014d372e03f3c9d
# bad: [1a10a44dfc1d55ba84987da1f8377258a044499c] sparc64: implement the new page table range API
git bisect bad 1a10a44dfc1d55ba84987da1f8377258a044499c
# first bad commit: [1a10a44dfc1d55ba84987da1f8377258a044499c] sparc64: implement the new page table range API
