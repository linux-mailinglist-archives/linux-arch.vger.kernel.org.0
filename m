Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85EB5790EFD
	for <lists+linux-arch@lfdr.de>; Mon,  4 Sep 2023 00:34:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242388AbjICWey (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 3 Sep 2023 18:34:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234565AbjICWex (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 3 Sep 2023 18:34:53 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AA1A90
        for <linux-arch@vger.kernel.org>; Sun,  3 Sep 2023 15:34:50 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-5008faf4456so1321216e87.3
        for <linux-arch@vger.kernel.org>; Sun, 03 Sep 2023 15:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1693780488; x=1694385288; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dIOhRbp78FSnOot0tcIQifKv7xD8tI587HuZagI+zEw=;
        b=WvKlUutqxlBUVSWYDAUtHok9nh0Pk9nt7HWH754g2tavi6EQGnnMLhePy+nr3c7aI2
         WlRAmDl4WID0bAk7pF1sSAtjPloolSd/2tzKOamzn7PTcU5RRt+DLZJMGxRPo2ZOQAVn
         iECD+ubk91nRmzyU43ijWr1iPcwmXpCqlVdBE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693780488; x=1694385288;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dIOhRbp78FSnOot0tcIQifKv7xD8tI587HuZagI+zEw=;
        b=a5kT+3nIIM9arsRijq0PL9Q+LnrJdctzn1USbbhOotQ4dR98Oh6aLWbyk/Pbafjezc
         5RPfPu4lMa9DdGWHhUj3/RxeouzxOv1HT5djgrdF3TsBGh7diEW+o7XZWQ9p9qrMQkEo
         4f8zDXrHj16PEK/cLjtF5unhilB/yh/PutsoepyI/5UUub5HKet8RC9VC16qZJRwK9AE
         m0EEOxikcKee/OPf5eTTWpB0QEHIE25Qs06cS0wWifDkK6J6BibmdQq9ka6CRy02Oo1W
         xRyWWOMK9llWd95zR67JFkxyAFt5F0WfDUTk4akU16HK2upe75YL0nrPmWFrNiPIUvaM
         NhaQ==
X-Gm-Message-State: AOJu0YyuJCwdChvDOOn8plomGBtXkIe5ORUV4S+BcZo3NQ2Ayql70yy8
        mUmCK2VNdhjXQu6l9bW8EFw7DBPg9kWJPmByS4aLKhkA
X-Google-Smtp-Source: AGHT+IGAxpHInzu+BfGBpoY3VvA9/KQFbdfYZ5QTdFH/5JJRg++ljTkxvM5GKft0g0qLxl8g+SEPow==
X-Received: by 2002:a05:6512:1c7:b0:500:bf33:3add with SMTP id f7-20020a05651201c700b00500bf333addmr4577640lfp.47.1693780488547;
        Sun, 03 Sep 2023 15:34:48 -0700 (PDT)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id t18-20020ac243b2000000b004fe3a8a9a0bsm1438005lfl.202.2023.09.03.15.34.47
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Sep 2023 15:34:48 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-500c7796d8eso1328181e87.1
        for <linux-arch@vger.kernel.org>; Sun, 03 Sep 2023 15:34:47 -0700 (PDT)
X-Received: by 2002:a05:6512:a88:b0:500:b53f:fbc2 with SMTP id
 m8-20020a0565120a8800b00500b53ffbc2mr6365297lfu.26.1693780487492; Sun, 03 Sep
 2023 15:34:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230830140315.2666490-1-mjguzik@gmail.com> <CAHk-=wgADyL9i8r1=YkRTehKG8T89TzqAFMXDJV1Ag+_4_25Cw@mail.gmail.com>
 <CAGudoHH95OKVgf0jW5pz_Nt2ab0HTnt3H9hbmU=aSHozOS5B0Q@mail.gmail.com>
 <CAHk-=wh+=W2k1V_0Om=_=QpPAN_VgHzdZ4FLXSfcyTSK7xo0Eg@mail.gmail.com>
 <CAHk-=wg6bzTdQHSsswHPYFUbb1DfszyWTZ97hZv7bYxaNHVkHw@mail.gmail.com>
 <20230903204858.lv7i3kqvw6eamhgz@f> <CAHk-=wjYOZf2wPj_=arATJ==DQQAQwh0ki=Za0RcE542rWBGFw@mail.gmail.com>
 <ZPT/LzkPR/jaiaDb@gmail.com>
In-Reply-To: <ZPT/LzkPR/jaiaDb@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 3 Sep 2023 15:34:30 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh1hi-HnBQRu9_ALQL-fbhyn_go+2c9FajO26khf2dsTw@mail.gmail.com>
Message-ID: <CAHk-=wh1hi-HnBQRu9_ALQL-fbhyn_go+2c9FajO26khf2dsTw@mail.gmail.com>
Subject: Re: [PATCH v2] x86: bring back rep movsq for user access on CPUs
 without ERMS
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Mateusz Guzik <mjguzik@gmail.com>, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, bp@alien8.de
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

On Sun, 3 Sept 2023 at 14:48, Ingo Molnar <mingo@kernel.org> wrote:
>
> If measurements support it then this looks like a nice optimization.

Well, it seems to work, but when I profile it to see if the end result
looks reasonable, the profile data is swamped by the return
mispredicts from CPU errata workarounds, and to a smaller degree by
the clac/stac overhead of SMAP.

So it does seem to work - at least it boots here and everything looks
normal - and it does seem to generate good code, but the profiles look
kind of sad.

I also note that we do a lot of stupid pointless 'statx' work that is
then entirely thrown away for a regular stat() system call.

Part of it is actual extra work to set the statx fields.

But a lot of it is that even if we didn't do that, the 'statx' code
has made 'struct kstat' much bigger, and made our code footprints much
worse.

Of course, even without the useless statx overhead, 'struct kstat'
itself ends up having a lot of padding because of how 'struct
timespec64' looks. It might actually be good to split it explicitly
into seconds and nanoseconds just for padding.

Because that all blows 'struct kstat' up to 160 bytes here.

And to make it all worse, the statx code has caused all the
filesystems to have their own 'getattr()' code just to fill in that
worthless garbage, when it used to be that you could rely on
'generic_fillattr()'.

I'm looking at ext4_getattr(), for example, and I think *all* of it is
due to statx - that to a close approximation nobody cares about, and
is a specialty system call for a couple of users

And again - the indirect branches have gone from being "a cycle or
two" to being pipeline stalls and mispredicts. So not using just a
plain 'generic_fillattr()' is *expensive*.

Sad. Because the *normal* stat() family of system calls are some of
the most important ones out there. Very much unlike statx().

              Linus
