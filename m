Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3D066E890F
	for <lists+linux-arch@lfdr.de>; Thu, 20 Apr 2023 06:22:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233141AbjDTEWB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 20 Apr 2023 00:22:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbjDTEWA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 20 Apr 2023 00:22:00 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 018362D4C;
        Wed, 19 Apr 2023 21:21:57 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1a66911f5faso6382155ad.0;
        Wed, 19 Apr 2023 21:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681964517; x=1684556517;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U8/f0BqrN3fbOh9nFqGySKf3YgZn5uXubEX6E6rTisE=;
        b=O4/gcXpyzQKh8KK1KxMFoppJ2K3Na6/K0myKKH2izfyrXf1ZW4NEG0UerBett+T+qJ
         GOiagxnkqcxd2foosvnWzNrHN8mZ56L0OtSaPHwy3+Kmvgd4WPY3iBj9b8lrczp44vO2
         hlyuX4b952suPUrM/rFZpK+6NvhglbsLbRN2EYfUi7lisox6nSPuZTwMJXa1G5lcbU+y
         RlSJeY9IdhxbsYCwYeNI751K/sOdbsZT5RZAdOZzgOW9668dMU5fOzkP8OrESyzC2osp
         LXp/dogbaFV22Nee/vKdaVvh5NnJF85yZBKt88+y1fXDYfVqkq7gZsNDmqmQZX18d4+5
         4Rlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681964517; x=1684556517;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U8/f0BqrN3fbOh9nFqGySKf3YgZn5uXubEX6E6rTisE=;
        b=OR1SPeahekKJSUweanfREmy6ls1eGXHBoxab4+mnMhyVUlqn7RIM6+7Xx60fE2TyHj
         kAgjwbaiRCJVqEVeORmx5Y4htsRWfgbbCJ9tSsaiUwAxNP22mzkH5wlJLNr9ah2zXe2L
         fIGf+LzyGXLNdufASG0sBUSExqBx2PGa15EPc0hBbxuPgKtwzR209P7R/og0F6zcTOQv
         HJzmRUNaaxul9jgQV4aI/I3Af4EMZ9GSB7RcPyq5OcNZo2A1glVNPnqxvTmTWEjjfFGG
         6OWeqUyHrpgsCWHJOr0FPXqr5/uYL08aKroYfktXENPgjKiRUPH9UakqaFkcmBioKl5X
         VhMg==
X-Gm-Message-State: AAQBX9cW0g6Rb/SjJCndzPaAqEi8yAZQOr9Uw7GOxHY3cRbb0JKKwVQc
        zmXneOZm1xq4bJRt0+N0Ft0=
X-Google-Smtp-Source: AKy350Zp2PCGi3/SwlJA+xWhwsGyKosdq4R6FG4kxjtw7Rw6J/eKGAkqwdaHeb3JDZ6gUruEyilM2A==
X-Received: by 2002:a17:902:f683:b0:1a8:17db:e252 with SMTP id l3-20020a170902f68300b001a817dbe252mr174219plg.34.1681964517386;
        Wed, 19 Apr 2023 21:21:57 -0700 (PDT)
Received: from [192.168.43.80] (subs03-180-214-233-9.three.co.id. [180.214.233.9])
        by smtp.gmail.com with ESMTPSA id iz12-20020a170902ef8c00b001a212a93295sm226115plb.189.2023.04.19.21.21.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Apr 2023 21:21:56 -0700 (PDT)
Message-ID: <16276cc1-2214-ef84-d5d8-d0c1a9681a0d@gmail.com>
Date:   Thu, 20 Apr 2023 11:21:50 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: Semantic conflict between x86 doc cleanup and CET shadow stack
 doc
Content-Language: en-US
To:     Jonathan Corbet <corbet@lwn.net>,
        Linux Documentation <linux-doc@vger.kernel.org>,
        Linux x86 <x86@kernel.org>,
        Linux Architectures <linux-arch@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Kees Cook <keescook@chromium.org>,
        Mike Rapoport <rppt@kernel.org>,
        Mark Brown <broonie@kernel.org>
References: <ZD+1XVjMvm8EvCzN@debian.me> <87mt34atxg.fsf@meer.lwn.net>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <87mt34atxg.fsf@meer.lwn.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 4/19/23 20:22, Jonathan Corbet wrote:
> https://lore.kernel.org/lkml/20230331142016.0a6f8f6b%40canb.auug.org.au/
> 

Thanks for the pointer 😌.

But I wonder why bronnie doesn't do this fixup...

-- 
An old man doll... just what I always wanted! - Clara

