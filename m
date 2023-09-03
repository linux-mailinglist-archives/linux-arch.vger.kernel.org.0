Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0DA2790DA4
	for <lists+linux-arch@lfdr.de>; Sun,  3 Sep 2023 21:15:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346300AbjICTPM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 3 Sep 2023 15:15:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231200AbjICTPM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 3 Sep 2023 15:15:12 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 764EB98
        for <linux-arch@vger.kernel.org>; Sun,  3 Sep 2023 12:15:08 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-99c1d03e124so105813766b.2
        for <linux-arch@vger.kernel.org>; Sun, 03 Sep 2023 12:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1693768506; x=1694373306; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wcdyOmYjlq1qQSUduy29DqZHuKGmSdrVaWwcehhzxKg=;
        b=NYN3Ltb0TvQ4v3jy0h1sy9bg4psCDtCCbEALOkvA9BcZVmbH/iDNMw4EeQ+ETBeMxF
         OuCe8FSjDjaL/e7EylYfZiqnU1MiC3Pf+kBYPr1KnalOh/6Rm+4nMAjcoirnBuQ92wwi
         OxBfc12+ai942Ot1g9IP8fpnq7pNL/7ie1Rd0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693768506; x=1694373306;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wcdyOmYjlq1qQSUduy29DqZHuKGmSdrVaWwcehhzxKg=;
        b=XeYzfNK7/JKUZilQRV/bS0wLKqPPKjRjBogDj7HAF6+3YClMHzm6KxiulByw5QQWhX
         t0YgG2UWFwaHfRddQzPWMiO1eOF3CM1Q7ejXyNr9Us9Ex/IDakBqzyZIQS3tJla/MtLe
         SAf41jLepH14k9FLqrqxXIx5IOXxFj/7AAitsq4kzemzDiSlvppLf0G3vH+U6epqBKGU
         jXJgGnOjLKkyvAfJ7DXobY8SLWDhquBCN7heq66cUbkMNFPD0cC7346LdeQskRBoOzLC
         RtRyCqOeBHGY5TuKgxLxaiGH+yzdsh5HyntAtZCL18F3y1p2kpN8THBCQwbwfRLcTGSi
         8q2A==
X-Gm-Message-State: AOJu0YwnZWiEEIanGWh1q/Qa0aAnnaeVx0Siim8hz7flI7Cj6er7Ee7B
        ycjF5mGO9kpvyTnlRy2F5651P/4GiYmDg+9YZFi8PH8C
X-Google-Smtp-Source: AGHT+IEQQk/UBhAAFEtSPCfCkfxpbiBNGx1121Lkt9uB/qooNlTlcwRZ7KzlFTkSwvUa5YElv9ZHbg==
X-Received: by 2002:a17:906:1daa:b0:9a6:5696:3879 with SMTP id u10-20020a1709061daa00b009a656963879mr116121ejh.65.1693768505632;
        Sun, 03 Sep 2023 12:15:05 -0700 (PDT)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com. [209.85.208.53])
        by smtp.gmail.com with ESMTPSA id s7-20020a170906c30700b0099cbfee34e3sm5098624ejz.196.2023.09.03.12.15.04
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Sep 2023 12:15:04 -0700 (PDT)
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-52bd9ddb741so980121a12.0
        for <linux-arch@vger.kernel.org>; Sun, 03 Sep 2023 12:15:04 -0700 (PDT)
X-Received: by 2002:aa7:d3cc:0:b0:52b:d169:b37b with SMTP id
 o12-20020aa7d3cc000000b0052bd169b37bmr5223697edr.35.1693768504178; Sun, 03
 Sep 2023 12:15:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230830140315.2666490-1-mjguzik@gmail.com> <CAHk-=wgADyL9i8r1=YkRTehKG8T89TzqAFMXDJV1Ag+_4_25Cw@mail.gmail.com>
 <CAGudoHH95OKVgf0jW5pz_Nt2ab0HTnt3H9hbmU=aSHozOS5B0Q@mail.gmail.com> <CAHk-=wh+=W2k1V_0Om=_=QpPAN_VgHzdZ4FLXSfcyTSK7xo0Eg@mail.gmail.com>
In-Reply-To: <CAHk-=wh+=W2k1V_0Om=_=QpPAN_VgHzdZ4FLXSfcyTSK7xo0Eg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 3 Sep 2023 12:14:46 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjrvn+J=z0_schGSROK0HCK-xs4wgky6pRKy7kVLhDeLg@mail.gmail.com>
Message-ID: <CAHk-=wjrvn+J=z0_schGSROK0HCK-xs4wgky6pRKy7kVLhDeLg@mail.gmail.com>
Subject: Re: [PATCH v2] x86: bring back rep movsq for user access on CPUs
 without ERMS
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

On Sun, 3 Sept 2023 at 11:49, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Why _is_ glibc doing that thing?

Oh, I think I may see where the confusion may come from.

The glibc people found a "__NR_newfstatat", and thought it was a newer
version of 'stat', and didn't find any new versions of the basic
stat/fstat/lstat functions at all. So they thought that everything
else was implemented using that 'newfstatat()' entrypoint.

But on x86-64 (and most half-way newer architectures), the regular
__NR_stat *is* that "new" stat.

After all, it was only "new" in 1992, long before x86-64 even existed.

So maybe somebody noticed that "__NR_newfstatat" is the only system
call number that has that "new" in the stat name, and didn't realize
that that was just an odd naming thing for strange historical reasons.

The relevant system call numbers are

  #define __NR_stat 4
  #define __NR_fstat 5
  #define __NR_lstat 6
  #define __NR_newfstatat 262
  #define __NR_statx 332

and the numbering very much is about when they were added.

And yes, that "new" in "newfstatat" is misleading, it's the same
'struct stat' as those stat/fstat/lstat system calls (but not the
'statx' one, that has 'struct statx', of course).

On x86-32, which has that extra decade of history, you end up with

  #define __NR_oldstat 18
  #define __NR_oldfstat 28
  #define __NR_oldlstat 84
  #define __NR_stat 106
  #define __NR_lstat 107
  #define __NR_fstat 108
  #define __NR_stat64 195
  #define __NR_lstat64 196
  #define __NR_fstat64 197
  #define __NR_fstatat64 300
  #define __NR_statx 383

where 106-108 are those "new" stat calls.  And then the stat64 ones
are the "new new" ones and the only version that was relevant by the
time we got the 'at()' version.

              Linus
