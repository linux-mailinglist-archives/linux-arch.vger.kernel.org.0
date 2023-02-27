Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C36E16A4EF6
	for <lists+linux-arch@lfdr.de>; Mon, 27 Feb 2023 23:55:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229481AbjB0WzC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 27 Feb 2023 17:55:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjB0WzB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 27 Feb 2023 17:55:01 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4499BBDFF;
        Mon, 27 Feb 2023 14:55:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E92A0B80DC5;
        Mon, 27 Feb 2023 22:54:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C1E1C433EF;
        Mon, 27 Feb 2023 22:54:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677538497;
        bh=oNi6mfEbmP/vFHqH7MNrcb1hzS4qKjn0LsQ+6mder/s=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=jkyfoc7WmIqGSDHAErhNPdiw90sU7qesTifylbE9t0zOFWxaIqUzgVNlxr26T6aGj
         gg4gsxsqemQKMK9uNyBOBd7Mxy1C15AangqA85eY910ebxHxZMjhxh744f0XV0BHSu
         neJ7cx6+uhnTFA2BEZd/FLvO7kNr2fAnnMB/MrCpEWKRptokU8CUr2d19sLQZwOLve
         eXaEIWymlZei8tzgHdzpURbXt9XW33FHI9WBmgbLpwmcxChUsusNlajirBTq6E3uN4
         Cq5q42kwt2th5oj6cG3YsukWTzq2lrsIIqBRRPL9FbhUjxx7tS0Kd3oa475Sasg1Y7
         dNlZiR56TrO1Q==
Date:   Mon, 27 Feb 2023 14:54:51 -0800
From:   Kees Cook <kees@kernel.org>
To:     Rick Edgecombe <rick.p.edgecombe@intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Balbir Singh <bsingharora@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H . J . Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Weijiang Yang <weijiang.yang@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        John Allen <john.allen@amd.com>, kcc@google.com,
        eranian@google.com, rppt@kernel.org, jamorris@linux.microsoft.com,
        dethoma@microsoft.com, akpm@linux-foundation.org,
        Andrew.Cooper3@citrix.com, christina.schimpe@intel.com,
        david@redhat.com, debug@rivosinc.com
CC:     rick.p.edgecombe@intel.com
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v7_27/41=5D_x86/mm=3A_Warn_if?= =?US-ASCII?Q?_create_Write=3D0=2CDirty=3D1_with_raw_prot?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20230227222957.24501-28-rick.p.edgecombe@intel.com>
References: <20230227222957.24501-1-rick.p.edgecombe@intel.com> <20230227222957.24501-28-rick.p.edgecombe@intel.com>
Message-ID: <4D6EB652-3271-485E-A15B-0AE0FA98DFC7@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On February 27, 2023 2:29:43 PM PST, Rick Edgecombe <rick=2Ep=2Eedgecombe@i=
ntel=2Ecom> wrote:
>When user shadow stack is use, Write=3D0,Dirty=3D1 is treated by the CPU =
as
>shadow stack memory=2E So for shadow stack memory this bit combination is
>valid, but when Dirty=3D1,Write=3D1 (conventionally writable) memory is b=
eing
>write protected, the kernel has been taught to transition the Dirty=3D1
>bit to SavedDirty=3D1, to avoid inadvertently creating shadow stack
>memory=2E It does this inside pte_wrprotect() because it knows the PTE is
>not intended to be a writable shadow stack entry, it is supposed to be
>write protected=2E
>
>However, when a PTE is created by a raw prot using mk_pte(), mk_pte()
>can't know whether to adjust Dirty=3D1 to SavedDirty=3D1=2E It can't
>distinguish between the caller intending to create a shadow stack PTE or
>needing the SavedDirty shift=2E
>
>The kernel has been updated to not do this, and so Write=3D0,Dirty=3D1
>memory should only be created by the pte_mkfoo() helpers=2E Add a warning
>to make sure no new mk_pte() start doing this=2E
>
>Tested-by: Pengfei Xu <pengfei=2Exu@intel=2Ecom>
>Tested-by: John Allen <john=2Eallen@amd=2Ecom>
>Tested-by: Kees Cook <keescook@chromium=2Eorg>
>Acked-by: Mike Rapoport (IBM) <rppt@kernel=2Eorg>
>Signed-off-by: Rick Edgecombe <rick=2Ep=2Eedgecombe@intel=2Ecom>

Reviewed-by: Kees Cook <keescook@chromium=2Eorg>


--=20
Kees Cook
