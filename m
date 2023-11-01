Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB5407DE736
	for <lists+linux-arch@lfdr.de>; Wed,  1 Nov 2023 22:08:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345631AbjKAUMb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 1 Nov 2023 16:12:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347762AbjKAUMa (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 1 Nov 2023 16:12:30 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51BC9ED
        for <linux-arch@vger.kernel.org>; Wed,  1 Nov 2023 13:12:28 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-6be0277c05bso260295b3a.0
        for <linux-arch@vger.kernel.org>; Wed, 01 Nov 2023 13:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1698869548; x=1699474348; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XBY0JWp+fvBCeujtT4HwLCwKShpFadpYymdfioiLqEY=;
        b=fLUGwmn/YMPlpSv3zjIS5KdUmNEb1RgacJfynZeBTMyl6g02CW5KfZuYlpJJ+m92q5
         CAk8opzGhUvQnHFlJkNZCwoFP8foDlCzRW6zMCZuVMCI6xuehvTGWMjwaSe2UtbLOu0d
         nr73E2y4oVFnFj7YiXwRvDLzNIXab/f/JcYxiY89PdiTw0w8Szrl4HbhwCMb42CmvZy0
         JAQU/c2Z/5Dd5FMiy1ZEJdgBLo+9/gdDLw7TA/YonCUxM88VlFfGhRwa0vkcia7o2Y9i
         KkerJ8Qshl25SHcB5zgLUtKDeanpH6amLHY57aeYdHHei4TRDzf9BhnXbwMHR5r8Odvn
         C0yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698869548; x=1699474348;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XBY0JWp+fvBCeujtT4HwLCwKShpFadpYymdfioiLqEY=;
        b=IIIcfRQlBrkqZLnpwkOXc/jwxWbfy7bRC4O7DMl9Amj1NXcNIisLKTSQa11pWLTPTy
         cZDQw2aY53tLLMvn5tgwSf7vnHmncgcN6Jkh6eV9+Cn8kFmJYgKMgU0+p8DT7/oK6dI1
         SwQeRkr39U28RmQxaSGuW5k2EZQsiLmZegH+FqN6yXXpYqvi+6RUJ36aikq0TaK1Tx/T
         WOA336lVyEetvnbeNBQL+UAJ7hRPZI7Vr1jPH+/KAU8b6MtgzWP9S1d+LMoANZR5wfZ7
         E+LKdUyzaQch6kzN66sXvJUM6RBbYxzW84M9BVBZXVPm1KcLmfgxj4mZHlOP2ndtXsit
         i+Jg==
X-Gm-Message-State: AOJu0YzJ7XtVcgF0oZ5Dv2C5fMPd7FSbjmRJT6I5KEok6Xm0K96GAfqo
        MtW/xY9j3emVY+9rlBzOBKul7w==
X-Google-Smtp-Source: AGHT+IGZCGUcTXRTOrpzR95F1FXg0ZwWYA/hCUz78Q1veCMd1klHXEEda84Z+O8rabrVvTyQI5zB/w==
X-Received: by 2002:a05:6a00:1797:b0:6b4:6b34:8cef with SMTP id s23-20020a056a00179700b006b46b348cefmr15788129pfg.34.1698869547714;
        Wed, 01 Nov 2023 13:12:27 -0700 (PDT)
Received: from ghost ([12.44.203.122])
        by smtp.gmail.com with ESMTPSA id u18-20020a056a00125200b00688435a9915sm1584901pfi.189.2023.11.01.13.12.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Nov 2023 13:12:27 -0700 (PDT)
Date:   Wed, 1 Nov 2023 13:12:24 -0700
From:   Charlie Jenkins <charlie@rivosinc.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Conor Dooley <conor@kernel.org>,
        Samuel Holland <samuel.holland@sifive.com>,
        David Laight <David.Laight@aculab.com>,
        Xiao W Wang <xiao.w.wang@intel.com>,
        Evan Green <evan@rivosinc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Subject: Re: [PATCH v9 5/5] riscv: Test checksum functions
Message-ID: <ZUKxKFlIHcxZWVKg@ghost>
References: <20231031-optimize_checksum-v9-0-ea018e69b229@rivosinc.com>
 <20231031-optimize_checksum-v9-5-ea018e69b229@rivosinc.com>
 <be85f9cb-25cb-4d58-a0db-9b85af240bba@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <be85f9cb-25cb-4d58-a0db-9b85af240bba@app.fastmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Nov 01, 2023 at 08:14:07PM +0100, Arnd Bergmann wrote:
> On Wed, Nov 1, 2023, at 01:18, Charlie Jenkins wrote:
> > Add Kconfig support for riscv specific testing modules. This was created
> > to supplement lib/checksum_kunit.c, and add tests for ip_fast_csum and
> > csum_ipv6_magic.
> >
> > Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> > ---
> >  arch/riscv/Kconfig.debug              |   1 +
> >  arch/riscv/lib/Kconfig.debug          |  31 ++++
> >  arch/riscv/lib/Makefile               |   2 +
> >  arch/riscv/lib/riscv_checksum_kunit.c | 330 ++++++++++++++++++++++++++++++++++
> 
> I don't understand this bit, what is special about riscv here
> that prevents you from adding it to the common lib/checksum_kunit.c?
> 
>        Arnd

Oh, I can add it to the common one. I was hesitant to do that just
because it would affect all archs.

- Charlie

