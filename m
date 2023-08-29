Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 424F078CD4C
	for <lists+linux-arch@lfdr.de>; Tue, 29 Aug 2023 22:04:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239312AbjH2UEZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 29 Aug 2023 16:04:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240474AbjH2UET (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 29 Aug 2023 16:04:19 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F794CC0
        for <linux-arch@vger.kernel.org>; Tue, 29 Aug 2023 13:04:14 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2bcfd3220d3so55865051fa.2
        for <linux-arch@vger.kernel.org>; Tue, 29 Aug 2023 13:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1693339452; x=1693944252; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=E7+fPH/MQHoNa3vChLqeUExHzKt7daOcGn55CTVmoBc=;
        b=iEdN0GNF1nWhyy3IF16S7OnEtMlSoMwG+HXNoqZCldV67/QGjVHuby2oBM4lstXdby
         V5zJ5ndCJOKJphewgeR5XslWA1aNivc0RntpwXM0VIiUrgWpLTCpMKU3D4oLS2jfIYGT
         NZDkzQV9xFIH7XbgJeRVCuMF8JVn/PuRf0PzU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693339452; x=1693944252;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E7+fPH/MQHoNa3vChLqeUExHzKt7daOcGn55CTVmoBc=;
        b=b+cR8hu6j+GeB1P4FF8ogdZ/zm9QHS4jaLqCoGO+z5WaUtkj/QGPIpDmAq+6kpOkOw
         wiUrmJaAbGfEuR94JJnRKPgp9iBiMvyJw8Nqtup5Hqg2OOodWoV73jzKSc+YVEDyoQfd
         iCl7QXY068nM5Rlxy8X8HwQ+ibFeRu7v93ul71+hAoM4XoOWGLb1xty5S0kWYkCRwI2y
         tzkDAYuW+7NkO9NKdmSwp3Xhgb2+BhOYSgvX8V/Q7e0cmTfQl2/jDM8Yzpfxt0pD2k2c
         E1OFmBXBq+VZ+3ai01tTtjxNaopmAVLzDjtK9nAplO8Apvf2LFkHc7Epw35TzfHhRDTb
         CxmA==
X-Gm-Message-State: AOJu0YyDKie2hEtdNU+nkJUSglOdcLBiR+OkX6/7BxAPZOvTmEakOAza
        CbU5rm2QsvcesOryXwMCWN7qb1T//SeUBZ1NTZ0AISMF
X-Google-Smtp-Source: AGHT+IFVofbPvwJ6JBR/u+iqGm9I/Z31F6SXR7bwVfayh6EBvi2+wogJGWDDZkRh0C2SeBMfmJeQcg==
X-Received: by 2002:a2e:3308:0:b0:2bc:b9cd:8bc2 with SMTP id d8-20020a2e3308000000b002bcb9cd8bc2mr194211ljc.4.1693339452026;
        Tue, 29 Aug 2023 13:04:12 -0700 (PDT)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com. [209.85.218.50])
        by smtp.gmail.com with ESMTPSA id ha19-20020a170906a89300b00989027eb30asm6262938ejb.158.2023.08.29.13.04.11
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Aug 2023 13:04:11 -0700 (PDT)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-99cdb0fd093so634477266b.1
        for <linux-arch@vger.kernel.org>; Tue, 29 Aug 2023 13:04:11 -0700 (PDT)
X-Received: by 2002:a17:906:51d4:b0:9a3:faf:7aa8 with SMTP id
 v20-20020a17090651d400b009a30faf7aa8mr55430ejk.10.1693339451148; Tue, 29 Aug
 2023 13:04:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230828170732.2526618-1-mjguzik@gmail.com> <CAHk-=wj=YwAsPUHN7Drem=Gj9xT6vvxgZx77ZecZVxOYYXpC0w@mail.gmail.com>
 <CAGudoHHnCKwObL7Y_4hiX7FmREiX6cGfte5EuyGitbXwe_RhkQ@mail.gmail.com>
In-Reply-To: <CAGudoHHnCKwObL7Y_4hiX7FmREiX6cGfte5EuyGitbXwe_RhkQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 29 Aug 2023 13:03:54 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgemNj9GBepSEJXS5N99rr9wLkL668UC9TsKH45NnJ7Mg@mail.gmail.com>
Message-ID: <CAHk-=wgemNj9GBepSEJXS5N99rr9wLkL668UC9TsKH45NnJ7Mg@mail.gmail.com>
Subject: Re: [PATCH] x86: bring back rep movsq for user access on CPUs without ERMS
To:     Mateusz Guzik <mjguzik@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        bp@alien8.de
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, 29 Aug 2023 at 12:45, Mateusz Guzik <mjguzik@gmail.com> wrote:
>
> So I think I know how to fix it, but I'm going to sleep on it.

I think you can just skip the %r8 games, and do that

        leal (%rax,%rcx,8),%rcx

in the exception fixup code, since %rax will have the low bits of the
byte count, and %rcx will have the remaining qword count.

We should also have some test-case for partial reads somewhere, but I
have to admit that when I did the cleanup patches I just wrote some
silly test myself (ie just doing a 'mmap()' and then reading/writing
into the end of that mmap at different offsets.

I didn't save that hacky thing, I'm afraid.

I also tried to figure out if there is any CPU we should care about
that doesn't like 'rep movsq', but I think you are right that there
really isn't. The "good enough" rep things were introduced in the PPro
if I recall correctly, and while you could disable them in the BIOS,
by the time Intel did 64-bit in Northwood (?) it was pretty much
standard.

So yeah, no reason to have the unrolled loop at all, and I think your
patch is fine conceptually, just needs fixing and testing for the
partial success case.

Oh, and you should also remove the clobbers of r8-r11 in the
copy_user_generic() inline asm in <asm/uaccess_64.h> when you've fixed
the exception handling. The only reason for those clobbers were for
that unrolled register use.

So only %rax ends up being a clobber for the rep_movs_alternative
case, as far as I can tell.

            Linus
