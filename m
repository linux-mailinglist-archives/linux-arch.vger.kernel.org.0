Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98BEC790E1A
	for <lists+linux-arch@lfdr.de>; Sun,  3 Sep 2023 23:09:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348364AbjICVJW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 3 Sep 2023 17:09:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348266AbjICVJW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 3 Sep 2023 17:09:22 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56B73106
        for <linux-arch@vger.kernel.org>; Sun,  3 Sep 2023 14:09:18 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-9a2a4a5472dso366942766b.1
        for <linux-arch@vger.kernel.org>; Sun, 03 Sep 2023 14:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1693775356; x=1694380156; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ETEfE0KXcMXBvMZBy08UTNp3OVjDrmaEtqJyFQMw/WY=;
        b=WONMALfu2j9ZAyF28WSrAF4vpDizubOoLLGn6KO4uIXMNvTR0002pwwMFTIWz/jQaN
         fBFPpPK3+INaAEvIViFxgqBTSzMgok/Wt28tyQLU9nXtVRUiHBOtLzPDf85OHiR2HaQQ
         YjmhP1sFUxAPnRwaSKo2PbNWwPOjVIUfyHVP4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693775356; x=1694380156;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ETEfE0KXcMXBvMZBy08UTNp3OVjDrmaEtqJyFQMw/WY=;
        b=ix5ZyKK5a6F2NPlnPU+nhJ44A/8Z2/6b/Ktue5Iwhf5+XQWjh4i7pwL5+HYljUxlSB
         1fCIvdU1Hjb072XOZxV+K4fJQosHFAHaH0+UFkni974tgLyqoJ8QeP0E7w4IQy8ggX7Y
         Lh2Xw2B75sMBFbsoNlajoQXJSDkpjKur3uAnxB5KQIf6tRuPwHOM/1zMh7O9SYQlKfBa
         oIke2SZBuoUYLpl6oHIXSuZu82cYAWwh6U5OPe/YxvY3zcC78ODgomzGUBHwJbYQgtb8
         VeOABvPZ+ZH27FbSSSxJ2o19o6RNuL/UezXX+ioZQmKSElkeGS3r5d1OTpxafnzU4hwk
         5BGw==
X-Gm-Message-State: AOJu0YxzMLm1eAOF05KxOqYUk6u0rPpthIEcwoMMTEShi/aQt3wtdSaw
        4Qxi6S4M2+Jtykqt7ERlGDuP4XFyzwHg1iMyCxcly8Pb
X-Google-Smtp-Source: AGHT+IFPiDTKKBVSCOjP6ykmGaWnEwmHvgMxEeDwmEaf2Cju290kkQ/4D1xsPS5ZJgPcbT06wu8fyA==
X-Received: by 2002:a17:906:5a63:b0:9a5:d710:dea5 with SMTP id my35-20020a1709065a6300b009a5d710dea5mr8117805ejc.17.1693775356672;
        Sun, 03 Sep 2023 14:09:16 -0700 (PDT)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com. [209.85.218.49])
        by smtp.gmail.com with ESMTPSA id r10-20020a170906c28a00b0099297782aa9sm5166183ejz.49.2023.09.03.14.09.15
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Sep 2023 14:09:15 -0700 (PDT)
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-9a1de3417acso370036566b.0
        for <linux-arch@vger.kernel.org>; Sun, 03 Sep 2023 14:09:15 -0700 (PDT)
X-Received: by 2002:aa7:c690:0:b0:523:c36e:ec8b with SMTP id
 n16-20020aa7c690000000b00523c36eec8bmr9015339edq.9.1693775355421; Sun, 03 Sep
 2023 14:09:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230830140315.2666490-1-mjguzik@gmail.com> <CAHk-=wgADyL9i8r1=YkRTehKG8T89TzqAFMXDJV1Ag+_4_25Cw@mail.gmail.com>
 <CAGudoHH95OKVgf0jW5pz_Nt2ab0HTnt3H9hbmU=aSHozOS5B0Q@mail.gmail.com>
 <CAHk-=wh+=W2k1V_0Om=_=QpPAN_VgHzdZ4FLXSfcyTSK7xo0Eg@mail.gmail.com>
 <CAHk-=wg6bzTdQHSsswHPYFUbb1DfszyWTZ97hZv7bYxaNHVkHw@mail.gmail.com>
 <20230903204858.lv7i3kqvw6eamhgz@f> <CAHk-=whHZ1KJGVKTaBOSr7KwYAqvrjD9bcoz-SKrsW3DdS9Eug@mail.gmail.com>
 <CAGudoHH-KZcmTjPQihiZ3cAYQwyNhw4q2Yvdrxr-xKBp8nTwPw@mail.gmail.com>
In-Reply-To: <CAGudoHH-KZcmTjPQihiZ3cAYQwyNhw4q2Yvdrxr-xKBp8nTwPw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 3 Sep 2023 14:08:58 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiohUShtCtCxee5-SGvMetd6vgnWgboLNHq2m4cpyNUJQ@mail.gmail.com>
Message-ID: <CAHk-=wiohUShtCtCxee5-SGvMetd6vgnWgboLNHq2m4cpyNUJQ@mail.gmail.com>
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

On Sun, 3 Sept 2023 at 14:06, Mateusz Guzik <mjguzik@gmail.com> wrote:
>
> I don't think it is *that* bad. I did a quick sanity check on that
> front by rolling with bpftrace on cases which pass AT_EMPTY_PATH *and*
> provide a path.

I guess you are right - nobody sane would use AT_EMPTY_PATH except if
they don't have a path.

Of course, the only reason we're discussing this in the first place is
because people are doing insane things, which makes _that_ particular
argument very weak indeed...

                     Linus
