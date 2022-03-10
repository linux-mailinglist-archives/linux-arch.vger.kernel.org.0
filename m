Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB4B94D5594
	for <lists+linux-arch@lfdr.de>; Fri, 11 Mar 2022 00:42:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243342AbiCJXng (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 10 Mar 2022 18:43:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240531AbiCJXnf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 10 Mar 2022 18:43:35 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60EBC33A3C
        for <linux-arch@vger.kernel.org>; Thu, 10 Mar 2022 15:42:33 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id t1so8765441edc.3
        for <linux-arch@vger.kernel.org>; Thu, 10 Mar 2022 15:42:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A5yzBGS/mlNNmuxREYecJ0lSlh7XloqoILtFR+wlGQg=;
        b=KFJStgni5znYnmP9HGJmG/egl0sxkTG7yQ8Q6VJ5bQo/ILCsjyRG3IEvkqaLDYdPjs
         kjPCBTRuDS2/ELQtP5IwaXG9DlLenBzx0gE4joiKfaN1L5mqc2jxcogSAtaLxYSC68IQ
         5i2SNDUIFct5kx/AgMbFT8v1hLo9Yw3vnGrRs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A5yzBGS/mlNNmuxREYecJ0lSlh7XloqoILtFR+wlGQg=;
        b=PqZqoMVBIpehC3VZSxpVMdvhxZMyKDLSRVPMQdySOK9pcHgABoVQwsKtpTm5tI4jbX
         HpcSBtOTAG7yIcAcCoHtf4QiBkbLxHCwDe7OiZ0ZjV/ZvIB/ABOLgFZTAwLx0uqF3YVq
         QBWMtVWkFIRbXwikbFx46/7n2gTItgh98UWN05SWwD55yxCY3VCoM8572ffI+uW2eACY
         rPeQc9815dEjf1R4LE6xAb8tDnaoq7tguBf3Wh+UBvOQ2eMmPF9SBwpWET1YE7NBM89Z
         ur07an18ZaG2l9SZF7VRY2iJYPpw2HHl2nNyRus11YanzwbiwOkhEUQSGnSAVK3GKbn6
         GLuA==
X-Gm-Message-State: AOAM5324L/4DajzMCNaYzQNg3I6vkO/XI15tg3wjACblHbYLW65qQSd0
        SurHryJiuGTOUMn04FErc+oC0eHVAHouiu25IEs=
X-Google-Smtp-Source: ABdhPJz5RrvsGIjUC/sQEjoiUFUd+V/Hf8bS3bA9WEtbCxgCREEfsdg0raguMSOcD07sWg+U8X0I0w==
X-Received: by 2002:a05:6402:27ca:b0:416:2fd7:7241 with SMTP id c10-20020a05640227ca00b004162fd77241mr6504356ede.22.1646955751779;
        Thu, 10 Mar 2022 15:42:31 -0800 (PST)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com. [209.85.218.53])
        by smtp.gmail.com with ESMTPSA id g26-20020a50ee1a000000b0041631c5b1f3sm2565939eds.30.2022.03.10.15.42.31
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Mar 2022 15:42:31 -0800 (PST)
Received: by mail-ej1-f53.google.com with SMTP id bi12so15639047ejb.3
        for <linux-arch@vger.kernel.org>; Thu, 10 Mar 2022 15:42:31 -0800 (PST)
X-Received: by 2002:a05:6512:2294:b0:448:6c86:3c78 with SMTP id
 f20-20020a056512229400b004486c863c78mr952676lfu.531.1646955338409; Thu, 10
 Mar 2022 15:35:38 -0800 (PST)
MIME-Version: 1.0
References: <20220113160115.5375-1-bp@alien8.de> <YeBzxuO0wLn/B2Ew@mit.edu>
 <YeCuNapJLK4M5sat@zn.tnic> <CAMuHMdUbTNNr16YY1TFe=-uRLjg6yGzgw_RqtAFpyhnOMM5Pvw@mail.gmail.com>
 <YeHLIDsjGB944GSP@zn.tnic> <CAMuHMdUBr+gpF6Z5nPadjHFYJwgGd+LGoNTV=Sxty+yaY5EWxg@mail.gmail.com>
 <YeHQmbMYyy92AbBp@zn.tnic> <YeKyBP5rac8sVvWw@zn.tnic> <b40d1377-51d5-4ba3-ab3f-b40626c229ad@physik.fu-berlin.de>
 <87ilsmdhb5.fsf_-_@email.froward.int.ebiederm.org> <164686349541.391760.11942525130947458475.b4-ty@chromium.org>
 <87czit4cae.fsf_-_@email.froward.int.ebiederm.org>
In-Reply-To: <87czit4cae.fsf_-_@email.froward.int.ebiederm.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 10 Mar 2022 15:35:22 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgpToUf0XORoH_t7Wrqv3=VcqCCDV2qnCbqjtCsrd3Cyg@mail.gmail.com>
Message-ID: <CAHk-=wgpToUf0XORoH_t7Wrqv3=VcqCCDV2qnCbqjtCsrd3Cyg@mail.gmail.com>
Subject: Re: [PATCH] x86: Remove a.out support
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?TcOlbnMgUnVsbGfDpXJk?= <mans@mansr.com>,
        "Theodore Ts'o" <tytso@mit.edu>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Michael Cree <mcree@orcon.net.nz>,
        linux-arch <linux-arch@vger.kernel.org>,
        Richard Henderson <rth@twiddle.net>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Borislav Petkov <bp@alien8.de>, Arnd Bergmann <arnd@arndb.de>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        X86 ML <x86@kernel.org>, Matt Turner <mattst88@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Mar 10, 2022 at 3:29 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> Kees can you pick this one up in for-next/execve as well?
>
> It still applies cleanly and the actual patch seems to have gotten lost
> in the conversation about what more we could do.

Side note: there are similar other turds if a.out goes away, ie on
alpha it's OSF4_COMPAT, and it enables support for a couple of legacy
OSF/1 system calls.

I think that was also discussed in the (old) a.out deprecation thread
back in 2019..

               Linus
