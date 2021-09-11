Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED9104074F3
	for <lists+linux-arch@lfdr.de>; Sat, 11 Sep 2021 05:49:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235425AbhIKDug (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 10 Sep 2021 23:50:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235306AbhIKDuX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 10 Sep 2021 23:50:23 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA276C0613E7
        for <linux-arch@vger.kernel.org>; Fri, 10 Sep 2021 20:49:03 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id rj12-20020a17090b3e8c00b001991428ded8so2259388pjb.1
        for <linux-arch@vger.kernel.org>; Fri, 10 Sep 2021 20:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=QuPF5nusJlsscFj3tnGPAk3mJ/xRENxHHvXDknweP7I=;
        b=xngk7xBTC3m78+CY9I+y4G9EDAP5+nxGEUr6zZjFicXSGgU5GX6GXnR3sFk6Ks6QBc
         1i17oG2CKO9UFB8RlY6CvORkr0z9lPI8KyUdfAcvbg0zpRgts3AjsuAgG+fmkJ9EvktC
         Mou3eFHI2zD0VbL5vGN7a6hrZA2+3uzkehA6S08/qzoP9P1IKng0wtwAJyN63Z+d53u6
         HhgD8q9URo6DIxmxLyJTaRGBGRLPTr6faChRlmrpIpH0aenlQSRf+IXyHDArqy/QdGfl
         jlub+/o3S+p99NEmXPXbFMGbyUJk/RYp4Ohoov1n0j7R7Jkubun0acdhaNL/U4+0L89b
         OAMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=QuPF5nusJlsscFj3tnGPAk3mJ/xRENxHHvXDknweP7I=;
        b=KQaJ0KTSen3RZhO3Cou00Q3tyEYbuKc1IkbMNmUtOKzPRrTcQTNNnn5K79gtlbe5Wc
         tWov24RH5WCIE3nLOeqJ1N/42Z4FCN+j1HQ+ZWn+xHJe1TFMs9qDDWWIAUkwv5vqFoF1
         pKWhPMobM19Tyuag6ExqQ24Dah8Dj+/WXPFeVn7PxHMhe1+adJSCEKl+5YN2yq40mClm
         bYjw7oTJCH/qqVWTDjrT6/WTgEMSqNPx1th8cTiUrApT/ap9mc1SitfNxt4m/emq/pnf
         LN4Q9XX8oHJtqAkelxTMwx4/6RtRHRogHocx9E01kAO+WMNBxfw0HX8lrmuWEmfIaFlt
         DG1w==
X-Gm-Message-State: AOAM532vVjanqx2qw1Dbeg2lDeSoGDGL3Sp5u8s0d6LjJyo2uwnQx76g
        Ig9qm/KHd83RoZE2QdgVW1Bdlw==
X-Google-Smtp-Source: ABdhPJwQaHKrcbkiR37heGOncNK7+R+ciRsCRoCbE/k/9aYTyGD/xAi2Fb7OtqtVU9rDTpHSXnMcxg==
X-Received: by 2002:a17:90a:fe0b:: with SMTP id ck11mr1099866pjb.10.1631332143174;
        Fri, 10 Sep 2021 20:49:03 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id w24sm304055pjh.30.2021.09.10.20.49.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Sep 2021 20:49:02 -0700 (PDT)
Date:   Fri, 10 Sep 2021 20:49:02 -0700 (PDT)
X-Google-Original-Date: Fri, 10 Sep 2021 20:23:04 PDT (-0700)
Subject:     Re: [PATCH] riscv: use the generic string routines
In-Reply-To: <CAFnufp0eVejrDJoGE900D2U5-9qi-srVEmPOc9zHC5mSH4DgLg@mail.gmail.com>
CC:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, Atish Patra <Atish.Patra@wdc.com>,
        kernel@esmil.dk, akira.tsukamoto@gmail.com, drew@beagleboard.org,
        bmeng.cn@gmail.com, David.Laight@aculab.com, guoren@kernel.org,
        Christoph Hellwig <hch@infradead.org>
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     mcroce@linux.microsoft.com
Message-ID: <mhng-22e6331c-16e1-40cc-b431-4990fda46ecf@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, 05 Aug 2021 03:31:04 PDT (-0700), mcroce@linux.microsoft.com wrote:
> On Wed, Aug 4, 2021 at 10:40 PM Palmer Dabbelt <palmer@dabbelt.com> wrote:
>>
>> On Tue, 03 Aug 2021 09:54:34 PDT (-0700), mcroce@linux.microsoft.com wrote:
>> > On Mon, Jul 19, 2021 at 1:44 PM Matteo Croce <mcroce@linux.microsoft.com> wrote:
>> >>
>> >> From: Matteo Croce <mcroce@microsoft.com>
>> >>
>> >> Use the generic routines which handle alignment properly.
>> >>
>> >> These are the performances measured on a BeagleV machine for a
>> >> 32 mbyte buffer:
>> >>
>> >> memcpy:
>> >> original aligned:        75 Mb/s
>> >> original unaligned:      75 Mb/s
>> >> new aligned:            114 Mb/s
>> >> new unaligned:          107 Mb/s
>> >>
>> >> memset:
>> >> original aligned:       140 Mb/s
>> >> original unaligned:     140 Mb/s
>> >> new aligned:            241 Mb/s
>> >> new unaligned:          241 Mb/s
>> >>
>> >> TCP throughput with iperf3 gives a similar improvement as well.
>> >>
>> >> This is the binary size increase according to bloat-o-meter:
>> >>
>> >> add/remove: 0/0 grow/shrink: 4/2 up/down: 432/-36 (396)
>> >> Function                                     old     new   delta
>> >> memcpy                                        36     324    +288
>> >> memset                                        32     148    +116
>> >> strlcpy                                      116     132     +16
>> >> strscpy_pad                                   84      96     +12
>> >> strlcat                                      176     164     -12
>> >> memmove                                       76      52     -24
>> >> Total: Before=1225371, After=1225767, chg +0.03%
>> >>
>> >> Signed-off-by: Matteo Croce <mcroce@microsoft.com>
>> >> Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
>> >> ---
>> >
>> > Hi,
>> >
>> > can someone have a look at this change and share opinions?
>>
>> This LGTM.  How are the generic string routines landing?  I'm happy to
>> take this into my for-next, but IIUC we need the optimized generic
>> versions first so we don't have a performance regression falling back to
>> the trivial ones for a bit.  Is there a shared tag I can pull in?
>
> Hi,
>
> I see them only in linux-next by now.

These ended up getting rejected by Linus, so I'm going to hold off on 
this for now.  If they're really out of lib/ then I'll take the C 
routines in arch/riscv, but either way it's an issue for the next 
release.
