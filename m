Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AE316467D5
	for <lists+linux-arch@lfdr.de>; Thu,  8 Dec 2022 04:33:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbiLHDdw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 7 Dec 2022 22:33:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230064AbiLHDdj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 7 Dec 2022 22:33:39 -0500
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E59596F0D3;
        Wed,  7 Dec 2022 19:32:43 -0800 (PST)
Received: by mail-ot1-x32c.google.com with SMTP id a7-20020a056830008700b0066c82848060so193904oto.4;
        Wed, 07 Dec 2022 19:32:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4HTuNTxF4T5sFlA1YwDZji6f9t/e5vLCSOfTCspGHiA=;
        b=EeR4ZKyzHaDvus3JUMmUEeOvKpaGh/3wXhK/gAsQXyuTo8K3Qgo6cVs2qZewn7wfTX
         6EuvNyQkJoDgk1L1b2hea45kv0gwJILfSQZyPOm4jqOOjJWWK6dJkrZAA1o1dWFBJ6MR
         igNa1GwUQN9DQtIFIgVFLQyFpwYIk0pNMupmrVXHOPmxuTJxW8Yh8l7XO/uqZUEYBYwM
         qoIhriDzPw/CI4RpE8PWJYJlTIMW2anQksyj+vs66mdM/BQcCnOSphivuYKosSZny7OX
         0nxAzkfMo9QWcTYAPv9KtUDmncjIsSXNIMBQ/BL7BCGKps2dRyZq7YzqD24HUjWj+2m5
         mLaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4HTuNTxF4T5sFlA1YwDZji6f9t/e5vLCSOfTCspGHiA=;
        b=YDpDSChtZLQks/jrrOFJZQh9nSoZYOGdSDXVEE1AqN9NJv5OktL+VWeYxoqhLSBL1o
         G0XDUIJ6UuLUS0HcU1V9i5Bjcbpec3Icqwo3g6MnFy9gHsmXh+c9iLHDcMbrtg+n7D5y
         x2qLgoOn1+iJ5LPsLOVw3Zz5zY+mFjfx1qkZ9BUnOEH0mcOY3bBMuH0lBkAiIwDfgEMe
         nexU7z2NUzarIOzU80vyTyEk2QSwUesRQOX5ydckup8h615iqK9eLWKGG1DepczfbT7L
         Lazs8zm0+X6RjgmALNjdMyJDMO7Kctv0/kheo7GHxKfI4ZWGmwFqTdorWhG8w7HnFvde
         /vyQ==
X-Gm-Message-State: ANoB5pmHS+nVGwLN21Gq/2cCd5WBdqyZ9AeVJhZQEikIPaCmv5skJw9E
        Ek75+GuxO3xNb7cwUc3ELienxiIzHcM=
X-Google-Smtp-Source: AA0mqf4hRJo3sPYD1mV+I8RCbLFLuFr1qA1/4rHYQBaziil637uteQJVFBlRlXDetjHLvFB+i1FcfA==
X-Received: by 2002:a9d:6c4f:0:b0:661:dfeb:f88b with SMTP id g15-20020a9d6c4f000000b00661dfebf88bmr548422otq.18.1670470362882;
        Wed, 07 Dec 2022 19:32:42 -0800 (PST)
Received: from localhost ([12.97.180.36])
        by smtp.gmail.com with ESMTPSA id cr5-20020a056830670500b006619533d1ddsm11005430otb.76.2022.12.07.19.32.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 19:32:42 -0800 (PST)
Date:   Wed, 7 Dec 2022 19:32:40 -0800
From:   Yury Norov <yury.norov@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH 0/3] bitmap: optimize small_const path for
Message-ID: <Y5Fa2BXvO+dpUqf0@yury-laptop>
References: <20221027043810.350460-1-yury.norov@gmail.com>
 <Y2Mi7PYO4ihnA+Pb@yury-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2Mi7PYO4ihnA+Pb@yury-laptop>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

ping again

On Wed, Nov 02, 2022 at 07:09:49PM -0700, Yury Norov wrote:
> Ping?
> 
> On Wed, Oct 26, 2022 at 09:38:07PM -0700, Yury Norov wrote:
> > Make all inline bitmap functions __always_inline to ensure that
> > small_const optimization is always possible, and improve on it for
> > find_next_bit() and friends.
> > 
> > Yury Norov (3):
> >   bitmap: switch from inline to __always_inline
> >   bitmap: improve small_const case for find_next() functions
> >   bitmap: add tests for find_next_bit()
> > 
> >  include/asm-generic/bitsperlong.h |  12 +++
> >  include/linux/bitmap.h            |  46 +++++-----
> >  include/linux/cpumask.h           | 144 +++++++++++++++---------------
> >  include/linux/find.h              |  85 ++++++++----------
> >  include/linux/nodemask.h          |  86 +++++++++---------
> >  lib/test_bitmap.c                 |  23 ++++-
> >  6 files changed, 208 insertions(+), 188 deletions(-)
> > 
> > -- 
> > 2.34.1
