Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 157857D7681
	for <lists+linux-arch@lfdr.de>; Wed, 25 Oct 2023 23:20:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbjJYVUa (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 25 Oct 2023 17:20:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjJYVU3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 25 Oct 2023 17:20:29 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A825D12A
        for <linux-arch@vger.kernel.org>; Wed, 25 Oct 2023 14:20:27 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id 46e09a7af769-6cd1918afb2so118861a34.0
        for <linux-arch@vger.kernel.org>; Wed, 25 Oct 2023 14:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1698268827; x=1698873627; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=x4R+fBPz/tYoWNwPb9Pp7jc9YbV1QMHyx6psPQvV2NA=;
        b=mr158P156/Z9KJDv08VPhWe22lAiExxKdjEjGw09Oy9Ryx3vnwevfoAsM1mb/Eep5Z
         GdhWMxpgRwK1C61JWfoXrYnEjtGNNfBxYjugtXY6CEDo6reTGSbe3q7q99h4W36OqzxX
         Ojp5L/buBcxj/NcDnssvPD2eRAdxYUZs418j3uWNlUJ8t/tlNZzNosJrAZPyyn1umFOY
         8nsTj5u7HK5nsYkiepcJiIHAvdWoCjhy5UIAgRVNk6tgIF5uu4sHDByK613UOtd5oG0c
         VTfNoeDwTpJOUQtXnb/B02IdJJPDItDVlLXBHk1U+5u9dB5hAokXhKLjukBvsigs1h75
         146w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698268827; x=1698873627;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x4R+fBPz/tYoWNwPb9Pp7jc9YbV1QMHyx6psPQvV2NA=;
        b=Ox1IGUtZFzekyUNR6ReTFYNHqdCmHZWzcRO7b5AIuYAlXc/pBlK1VxvGT2kVKwNN4G
         4okSswXV/DNKLr8kJhlFeuUY5WKo4LNwX0GnV6F+biep2tTN1JVHnRu27PVjTugq03Re
         kgoPu9JoRj6a0yhWtGJU2bNQmGrcvVF/+1uYTCDvchdxiqsgIQsQthjgBDVdlw6Jcgb/
         /IohxZsBmjM9X7UHNBYzgcW5UTUuYkva+nuExj0U3cyYbL0Qwlez7FXpY7n65ZzufuRd
         4Xu5rGw3JejxFBkdQ8BFLqhOKft7gE5PO3IrlGc1NpZFLewrYGWCas6O4UZETaKWKF+s
         3kVQ==
X-Gm-Message-State: AOJu0YxbFxB5VDLnOWYkZoc1zVt4OrN5fcdRzY867mf0ulMsh7gQ29LY
        KUCJrPP2PU8Uku6h8YqrTR2t+8lVD3qTEwDnCPE=
X-Google-Smtp-Source: AGHT+IGav5/1dQVNAHhyYvy58dHFfkWIu/JtH4MUc2KdaTCN0BgNu4GrGfs3WwaokFiLCk2KDuCXfg==
X-Received: by 2002:a05:6830:7:b0:6b8:9a3a:ea12 with SMTP id c7-20020a056830000700b006b89a3aea12mr18253103otp.12.1698268827023;
        Wed, 25 Oct 2023 14:20:27 -0700 (PDT)
Received: from ghost ([208.116.208.98])
        by smtp.gmail.com with ESMTPSA id r125-20020a4a4e83000000b0057b38a94f38sm166296ooa.12.2023.10.25.14.20.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 14:20:26 -0700 (PDT)
Date:   Wed, 25 Oct 2023 14:20:23 -0700
From:   Charlie Jenkins <charlie@rivosinc.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     "Wang, Xiao W" <xiao.w.wang@intel.com>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Conor Dooley <conor@kernel.org>,
        David Laight <David.Laight@aculab.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH v7 2/4] riscv: Checksum header
Message-ID: <ZTmGl36A3X1UtnNu@ghost>
References: <20230919-optimize_checksum-v7-0-06c7d0ddd5d6@rivosinc.com>
 <20230919-optimize_checksum-v7-2-06c7d0ddd5d6@rivosinc.com>
 <DM8PR11MB575134C301E7E17E72281CFAB8DEA@DM8PR11MB5751.namprd11.prod.outlook.com>
 <ZTl8gauEst2NGrw6@ghost>
 <059f17e6-e240-40fa-8742-7844ad3b3502@app.fastmail.com>
 <ZTmEkYn1NcUvL58n@ghost>
 <571211a1-470a-43da-a603-fd12a640b7a8@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <571211a1-470a-43da-a603-fd12a640b7a8@app.fastmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Oct 25, 2023 at 11:18:40PM +0200, Arnd Bergmann wrote:
> On Wed, Oct 25, 2023, at 23:11, Charlie Jenkins wrote:
> >
> > Thank you for pointing that out, I had not realized that macro existed.
> > Since riscv keeps NET_IP_ALIGN at 0 it should be expected that
> > ip_fast_csum is only called with 32-bit aligned addresses. I will update
> > the comment and refer to that macro. riscv supports misaligned accesses
> > but there are no guarantees of speed.
> 
> Just to clarify for your comment: riscv gets the default value of '2',
> which is the one that makes the header aligned.
> 
>       Arnd

Oops, typo. I meant to write 2.

- Charlie

