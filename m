Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2E1F73883F
	for <lists+linux-arch@lfdr.de>; Wed, 21 Jun 2023 17:01:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbjFUPA7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 21 Jun 2023 11:00:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233241AbjFUPAK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 21 Jun 2023 11:00:10 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CBD02106
        for <linux-arch@vger.kernel.org>; Wed, 21 Jun 2023 07:54:58 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1b55bc0c907so30782135ad.0
        for <linux-arch@vger.kernel.org>; Wed, 21 Jun 2023 07:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20221208.gappssmtp.com; s=20221208; t=1687359241; x=1689951241;
        h=message-id:to:from:cc:in-reply-to:subject:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NEunxZx+vC6MelzaldzUGnTGO3Vi7pASMkXGIahe5XA=;
        b=i7XzxVV4Mf+kiHnx8OI4XIUzUBrOOuUtw83TzX3ObDbNWldX5/knsM5Z2FozYWGskt
         uNRng4wZP0+SujABsdgqz1QZNhasjdAC/XgLe8untJc3BOUSLbL8m7SGqaPj1i5VkJEZ
         QnS48sKtYZHITrVtQwPui2pIwiZkhNYhy0rYbe1aD+v72N9qiza9ZOlTFRLclUodtjN+
         NrEvHgRiSMhAdpjyGz85d2NkUna8ge7v54x+Xr/3I5T1grXRXnIsnyfokY6/z08eyrD+
         XA/N8l73U68N4MAq9/GclduZgp9EjNQOFJQ2Vp1/obiRyBYHj0bBel8zCDBHBXojUjty
         KswQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687359241; x=1689951241;
        h=message-id:to:from:cc:in-reply-to:subject:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NEunxZx+vC6MelzaldzUGnTGO3Vi7pASMkXGIahe5XA=;
        b=KY39zAVGeUDUyslrINHudft0jgAlu94CTMgjUIDbjCm3PYyS0M9FVndfBnNc2ExZWN
         9zjnHc98v5mgaalXyUfKYQgENppequNAgu8deeR/9v1tkzoM//K7tmoDbCETKSmPJt4r
         1gv9SR83xP/6nJfVpHMs9oqo3dAY12WqxXT89xR9Ku1I35B8v0cX5G1ijNGnyFj45ebE
         9RY/lBDGiebYwbOkMpCiAzOyHNXK0y6v0K8Tp4wnsOVcaxgQJI4+tVRy9sqAf1C2577C
         RyZqXZjhPAkgIMnR+aXGC1K0dkTqjjBbSX8SPp4T5ZY/uRNpV22BwRG+UcOOE1tcAjUD
         zysg==
X-Gm-Message-State: AC+VfDzs7P9iSXl1avR0wa4s26qXEc1LRh6P5PL+KeNuUqUWrojjBpeN
        l0d8ZsU8eZFEhRszKWrjE7Ie4A==
X-Google-Smtp-Source: ACHHUZ5qKimugwIwWMm1fA+NHwlYg1WzZa5xNfgcuxC0docRuW4FMER/iDzKWVeYBtiFfDVC/1wnBQ==
X-Received: by 2002:a17:903:1250:b0:1ac:aba5:7885 with SMTP id u16-20020a170903125000b001acaba57885mr18055679plh.47.1687359240597;
        Wed, 21 Jun 2023 07:54:00 -0700 (PDT)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id d12-20020a170902cecc00b001b03a7a40e7sm3638417plg.19.2023.06.21.07.53.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 07:53:59 -0700 (PDT)
Date:   Wed, 21 Jun 2023 07:53:59 -0700 (PDT)
X-Google-Original-Date: Wed, 21 Jun 2023 07:53:17 PDT (-0700)
Subject:     Re: [PATCH v2 0/4] riscv: enable HAVE_LD_DEAD_CODE_DATA_ELIMINATION
In-Reply-To: <mhng-8caf7779-aa9e-496a-b2ee-2e6d6d1d76ff@palmer-ri-x1c9a>
CC:     Conor Dooley <conor@kernel.org>, jszhang@kernel.org,
        llvm@lists.linux.dev, Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, Arnd Bergmann <arnd@arndb.de>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     ndesaulniers@google.com
Message-ID: <mhng-861ea8a6-c92c-4a78-a1a6-dfb4df554aee@palmer-ri-x1c9a>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,PP_MIME_FAKE_ASCII_TEXT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, 20 Jun 2023 17:13:17 PDT (-0700), Palmer Dabbelt wrote:
> On Tue, 20 Jun 2023 14:08:33 PDT (-0700), Palmer Dabbelt wrote:
>> On Tue, 20 Jun 2023 13:47:07 PDT (-0700), ndesaulniers@google.com wrote:
>>> On Tue, Jun 20, 2023 at 4:41 PM Palmer Dabbelt <palmer@dabbelt.com> wrote:
>>>>
>>>> On Tue, 20 Jun 2023 13:32:32 PDT (-0700), ndesaulniers@google.com wrote:
>>>> > On Tue, Jun 20, 2023 at 4:13 PM Conor Dooley <conor@kernel.org> wrote:
>>>> >>
>>>> >> On Tue, Jun 20, 2023 at 04:05:55PM -0400, Nick Desaulniers wrote:
>>>> >> > On Mon, Jun 19, 2023 at 6:06 PM Palmer Dabbelt <palmer@dabbelt.com> wrote:
>>>> >> > > On Thu, 15 Jun 2023 06:54:33 PDT (-0700), Palmer Dabbelt wrote:
>>>> >> > > > On Wed, 14 Jun 2023 09:25:49 PDT (-0700), jszhang@kernel.org wrote:
>>>> >> > > >> On Wed, Jun 14, 2023 at 07:49:17AM -0700, Palmer Dabbelt wrote:
>>>> >> > > >>> On Tue, 23 May 2023 09:54:58 PDT (-0700), jszhang@kernel.org wrote:
>>>> >>
>>>> >> > > >> Commit 3b90b09af5be ("riscv: Fix orphan section warnings caused by
>>>> >> > > >> kernel/pi") touches vmlinux.lds.S, so to make the merge easy, this
>>>> >> > > >> series is based on 6.4-rc2.
>>>> >> > > >
>>>> >> > > > Thanks.
>>>> >> > >
>>>> >> > > Sorry to be so slow here, but I think this is causing LLD to hang on
>>>> >> > > allmodconfig.  I'm still getting to the bottom of it, there's a few
>>>> >> > > other things I have in flight still.
>>>> >> >
>>>> >> > Confirmed with v3 on mainline (linux-next is pretty red at the moment).
>>>> >> > https://lore.kernel.org/linux-riscv/20230517082936.37563-1-falcon@tinylab.org/
>>>> >>
>>>> >> Just FYI Nick, there's been some concurrent work here from different
>>>> >> people working on the same thing & the v3 you linked (from Zhangjin) was
>>>> >> superseded by this v2 (from Jisheng).
>>>> >
>>>> > Ah! I've been testing the deprecated patch set, sorry I just looked on
>>>> > lore for "dead code" on riscv-linux and grabbed the first thread,
>>>> > without noticing the difference in authors or new version numbers for
>>>> > distinct series. ok, nevermind my noise.  I'll follow up with the
>>>> > correct patch set, sorry!
>>>>
>>>> Ya, I hadn't even noticed the v3 because I pretty much only look at
>>>> patchwork these days.  Like we talked about in IRC, I'm going to go test
>>>> the merge of this one and see what's up -- I've got it staged at
>>>> <https://git.kernel.org/pub/scm/linux/kernel/git/palmer/linux.git/commit/?h=for-next&id=1bd2963b21758a773206a1cb67c93e7a8ae8a195>,
>>>> though that won't be a stable hash if it's actually broken...
>>>
>>> Ok, https://lore.kernel.org/linux-riscv/20230523165502.2592-1-jszhang@kernel.org/
>>> built for me.  If you're seeing a hang, please let me know what
>>> version of LLD you're using and I'll build that tag from source to see
>>> if I can reproduce, then bisect if so.
>>>
>>> $ ARCH=riscv LLVM=1 /usr/bin/time -v make -j128 allmodconfig vmlinux
>>> ...
>>>         Elapsed (wall clock) time (h:mm:ss or m:ss): 2:35.68
>>> ...
>>>
>>> Tested-by: Nick Desaulniers <ndesaulniers@google.com> # build
>>
>> OK, it triggered enough of a rebuild that it might take a bit for
>> anything to filter out.
>
> I'm on LLVM 16.0.2
>
>     $ git describe
>     llvmorg-16.0.2
>     $ git log | head -n1
>     commit 18ddebe1a1a9bde349441631365f0472e9693520
>
> that seems to hang for me -- or at least run for an hour without
> completing, so I assume it's hung.  I'm not wed to 16.0.2, it just
> happens to be the last time I bumped the toolchain.  I'm moving to
> 16.0.5 to see if that changes anything.

That also takes at least an hour to link.  I tried running on LLVM trunk 
from last night

    $ git log | head -n1
    commit 5e9173c43a9b97c8614e36d6f754317f731e71e9

and that completed.  Just as a curiosity I tried to re-spin it to see 
how long it takes, and it's been running for 23 minutes so far.

So I'm no longer actually sure there's a hang, just something slow.  
That's even more of a grey area, but I think it's sane to call a 1-hour 
link time a regression -- unless it's expected that this is just very 
slow to link?

>
>>
>> Thanks!
>>
>>>
>>>>
>>>> >
>>>> >>
>>>> >> Cheers,
>>>> >> Conor.
>>>> >
>>>> >
>>>> >
>>>> > --
>>>> > Thanks,
>>>> > ~Nick Desaulniers
>>>
>>>
>>>
>>> --
>>> Thanks,
>>> ~Nick Desaulniers
