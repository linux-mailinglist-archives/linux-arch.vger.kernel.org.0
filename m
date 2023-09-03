Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3864790E22
	for <lists+linux-arch@lfdr.de>; Sun,  3 Sep 2023 23:18:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348371AbjICVSu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 3 Sep 2023 17:18:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjICVSs (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 3 Sep 2023 17:18:48 -0400
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 889EA103;
        Sun,  3 Sep 2023 14:18:45 -0700 (PDT)
Received: by mail-oo1-xc2a.google.com with SMTP id 006d021491bc7-573921661a6so550896eaf.1;
        Sun, 03 Sep 2023 14:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693775925; x=1694380725; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OjwRi8j33QFkaYf1YUSlqQ4jT9Yz3y1s6c8vlWxQhc8=;
        b=Z1XTlOfj4Dl5I5Y+jBDeRyFNEl/VIRRLaHdhE4398+yqCUZLxgoLets68XxDQrR36y
         zKMRg3o+jZKT66mdSrn/jBi5YAGMfVngiIinARwlBSeiopi4bBQ+qzj0c4z9Dwjmp/SY
         T9rS7g+TiD7pZovP1tbsRkitVLKdUkPWZVCxsA761rLdkQ5tnKhvqurlP6fica1B08TM
         yyA4OmmnNmv5pu1eF/+R/CDg4Is2H5rWnViba7Ydcyf9s9JS3DR8bgn/ocXqyNcW56UM
         imOPuRNRECigYCnVtK/gtcbEEr4eB0lhGYjau67BXyTzEiQzNAkAAMoD/GyNTG5R/Yd+
         h34A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693775925; x=1694380725;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OjwRi8j33QFkaYf1YUSlqQ4jT9Yz3y1s6c8vlWxQhc8=;
        b=WpUgQxnuSYiiCS3BygrYiWZGdHV6LNqRoXDwWG88GlI1D41lJLLEQRzALiaGkjCQ2y
         /gVYsVb9yAAfQcMetlg74TRpE5dX3DWSjZzPaVHE88m0cj6NsXW2dQKLE67EKmmSXFHn
         EsD5RdVvv2Q/FphhC0i3oNj1Evgvyxa69udlybtLo0FlIwjo6CoHnxKue6pma81JYGqs
         TNaILbfhQfpkQfBFDt26WQvmfTYhkShh7psJUn/8ciqZ9su5PJ/OiXrenGMw9R01RHhN
         u9WhNXvRdW9oUBF82cagRgtf+FdhTSx0/uvrDJPiyi30UHOlxbbWbPaJ/46jZw6iuA2a
         iEBw==
X-Gm-Message-State: AOJu0YxNJwYucGJi4N5VW7LUtRft0IT6FyRqq2YxmTjiZ61A7cjBP4OW
        twR5X059IdTs5lvalJxo0HeLk3GNwm/0l4lHfx4=
X-Google-Smtp-Source: AGHT+IHFxkh5Ff+S+BnhXd2iw3odzt8l7A8HmiqQIIoD3+DFfbivm34DFQw6Opjz6oVGPjcyqjj5Q1FfgsokHFDkT4g=
X-Received: by 2002:a4a:2b42:0:b0:56c:7c3b:1c21 with SMTP id
 y2-20020a4a2b42000000b0056c7c3b1c21mr6415239ooe.0.1693775924707; Sun, 03 Sep
 2023 14:18:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a8a:60c:0:b0:4f0:1250:dd51 with HTTP; Sun, 3 Sep 2023
 14:18:44 -0700 (PDT)
In-Reply-To: <CAHk-=wiohUShtCtCxee5-SGvMetd6vgnWgboLNHq2m4cpyNUJQ@mail.gmail.com>
References: <20230830140315.2666490-1-mjguzik@gmail.com> <CAHk-=wgADyL9i8r1=YkRTehKG8T89TzqAFMXDJV1Ag+_4_25Cw@mail.gmail.com>
 <CAGudoHH95OKVgf0jW5pz_Nt2ab0HTnt3H9hbmU=aSHozOS5B0Q@mail.gmail.com>
 <CAHk-=wh+=W2k1V_0Om=_=QpPAN_VgHzdZ4FLXSfcyTSK7xo0Eg@mail.gmail.com>
 <CAHk-=wg6bzTdQHSsswHPYFUbb1DfszyWTZ97hZv7bYxaNHVkHw@mail.gmail.com>
 <20230903204858.lv7i3kqvw6eamhgz@f> <CAHk-=whHZ1KJGVKTaBOSr7KwYAqvrjD9bcoz-SKrsW3DdS9Eug@mail.gmail.com>
 <CAGudoHH-KZcmTjPQihiZ3cAYQwyNhw4q2Yvdrxr-xKBp8nTwPw@mail.gmail.com> <CAHk-=wiohUShtCtCxee5-SGvMetd6vgnWgboLNHq2m4cpyNUJQ@mail.gmail.com>
From:   Mateusz Guzik <mjguzik@gmail.com>
Date:   Sun, 3 Sep 2023 23:18:44 +0200
Message-ID: <CAGudoHHOEMvz6=JZ2XZYKgKTqQ-FeCcXxVEvS2xBncn-ck5JXg@mail.gmail.com>
Subject: Re: [PATCH v2] x86: bring back rep movsq for user access on CPUs
 without ERMS
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        bp@alien8.de
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 9/3/23, Linus Torvalds <torvalds@linux-foundation.org> wrote:
> On Sun, 3 Sept 2023 at 14:06, Mateusz Guzik <mjguzik@gmail.com> wrote:
>>
>> I don't think it is *that* bad. I did a quick sanity check on that
>> front by rolling with bpftrace on cases which pass AT_EMPTY_PATH *and*
>> provide a path.
>
> I guess you are right - nobody sane would use AT_EMPTY_PATH except if
> they don't have a path.
>
> Of course, the only reason we're discussing this in the first place is
> because people are doing insane things, which makes _that_ particular
> argument very weak indeed...
>

I put blame on whoever allowed non-NULL path and AT_EMPTY_PATH as a
valid combination, forcing the user buf to be accessed no matter what.
But I'm not going to go digging for names. ;)

-- 
Mateusz Guzik <mjguzik gmail.com>
