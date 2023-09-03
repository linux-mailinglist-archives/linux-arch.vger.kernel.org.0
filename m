Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27D1A790DFE
	for <lists+linux-arch@lfdr.de>; Sun,  3 Sep 2023 22:53:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234197AbjICUtH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 3 Sep 2023 16:49:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234185AbjICUtG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 3 Sep 2023 16:49:06 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EBBCDC;
        Sun,  3 Sep 2023 13:49:03 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-9a603159f33so117057066b.0;
        Sun, 03 Sep 2023 13:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693774142; x=1694378942; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=L9jT9MyxZgUeiBeWFBrtB3yfqjmSosc9HfW3PGTm+r8=;
        b=RdRaEeFXpPEJ6hhLGpJhfPefIDL8jIbzGS9bE4bkoOIBu1M0G7fAps1U4NVQXXCiRa
         rWdfT1V5GxR0p1G7ED/XIHOl0nYWjv4fr4oint2wQS6S1t/zZ46r8T12EatwD5QT9FoX
         Jfv/nzBZlVl5KdjTTefwRayUtIFQGaEIOsH/6Oc2O781uvfS5twRA7gccw01C7pIdSIY
         jMeSZQ0dGDeBksZi/TBy64pvv3c1dZpRUZK7wvzrbW/JIkCEYibbmxQqI4KHZretog+w
         uiQh/eodKvkQxXHDQFJcvrj57fBtHEh4FiRvuuxC0n7Ko2YD/ocsYcT8qhM+DFUN5QqE
         aQzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693774142; x=1694378942;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L9jT9MyxZgUeiBeWFBrtB3yfqjmSosc9HfW3PGTm+r8=;
        b=jZcol4BYZyEb2e1m7ZauP41PZv2VaoL0xTqvDte2fSIgV4RP/oCak5lUqY8ZDVizT0
         25eoaIzt6/DDs+KlINn5phvE/7c4+CT4UtE+SmPuCf12RdjZzERcPr35BGPgBy+2/Z9N
         PloHXpgQSFl920MyUGYS4HBdtBtmY3C87A1Jsec8REbdxiwN5TqwibIuw/KKho7UQofE
         wlDGDJnxgI1k8UGmZGm8xRcjqQIsfSV84qtGNDuvLU84EH/sJ424ZIuz9fzt5/hn2sv8
         4IkVJDKwr6AqdS6/UKQNjhmVs0gbgJO1gK62pcSkdl5nOZmr+dckcoJZjUorveNpkAeB
         cjOA==
X-Gm-Message-State: AOJu0YzmJZzH+xtAFPYdfQASayJC6ByQtM7NLxZNWjithOuPVIBftSmd
        XjeQ+jK0qnWQOtYnYOSo/xY=
X-Google-Smtp-Source: AGHT+IFJ4F6HFryW5fi25+em2LnsluYdVuE4EByo/4QYrvPwJsCmdIMX1jw0H2Iitodk8+V3175d4Q==
X-Received: by 2002:a17:907:2cd5:b0:9a5:7e63:2df with SMTP id hg21-20020a1709072cd500b009a57e6302dfmr5979238ejc.1.1693774141689;
        Sun, 03 Sep 2023 13:49:01 -0700 (PDT)
Received: from f (cst-prg-30-15.cust.vodafone.cz. [46.135.30.15])
        by smtp.gmail.com with ESMTPSA id dk24-20020a170906f0d800b00992d0de8762sm5193204ejb.216.2023.09.03.13.49.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Sep 2023 13:49:01 -0700 (PDT)
Date:   Sun, 3 Sep 2023 22:48:58 +0200
From:   Mateusz Guzik <mjguzik@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        bp@alien8.de
Subject: Re: [PATCH v2] x86: bring back rep movsq for user access on CPUs
 without ERMS
Message-ID: <20230903204858.lv7i3kqvw6eamhgz@f>
References: <20230830140315.2666490-1-mjguzik@gmail.com>
 <CAHk-=wgADyL9i8r1=YkRTehKG8T89TzqAFMXDJV1Ag+_4_25Cw@mail.gmail.com>
 <CAGudoHH95OKVgf0jW5pz_Nt2ab0HTnt3H9hbmU=aSHozOS5B0Q@mail.gmail.com>
 <CAHk-=wh+=W2k1V_0Om=_=QpPAN_VgHzdZ4FLXSfcyTSK7xo0Eg@mail.gmail.com>
 <CAHk-=wg6bzTdQHSsswHPYFUbb1DfszyWTZ97hZv7bYxaNHVkHw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wg6bzTdQHSsswHPYFUbb1DfszyWTZ97hZv7bYxaNHVkHw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, Sep 03, 2023 at 01:08:03PM -0700, Linus Torvalds wrote:
> On Sun, 3 Sept 2023 at 11:49, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > So I have no idea why you claim that "currently they have no choice".
> > glibc is simply being incredibly stupid, and using newfstatat() for no
> > good reason.
> 
> Do you have any good benchmark that shows the effects of this?
> 
> And if you do, does the attached patch (ENTIRELY UNTESTED!) fix the
> silly glibc mis-feature?
> 

"real fstat" is syscall(5, fd, &sb).

Sapphire Rapids, will-it-scale, ops/s

stock fstat	5088199
patched fstat	7625244	(+49%)
real fstat	8540383	(+67% / +12%)

It dodges lockref et al, but it does not dodge SMAP which accounts for
the difference.
