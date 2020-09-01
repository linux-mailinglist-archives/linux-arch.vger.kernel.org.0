Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC3AB259ED9
	for <lists+linux-arch@lfdr.de>; Tue,  1 Sep 2020 20:57:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731245AbgIAS5l (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 1 Sep 2020 14:57:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730661AbgIAS5j (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 1 Sep 2020 14:57:39 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5335C061244
        for <linux-arch@vger.kernel.org>; Tue,  1 Sep 2020 11:57:39 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id ds1so1089871pjb.1
        for <linux-arch@vger.kernel.org>; Tue, 01 Sep 2020 11:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=myAjLsXJJ5WrIyplttBLOJrb3cYFWSnfDJgomMmHBsY=;
        b=ebiQOl0HdWb1qsZ8K4nAaddfFhbr3U7deevLOcXXTD6OLvfKSnSROhSsCjgZ7mCdSU
         KEk3JPhKcmdeA0QtKKnHHoNdav2XUrlVbf6RKDK+ixxHf+lELn4fBRXQcE7RzE2wmQCF
         jhg7c/3b8g07wxtC6uK6VnR8kOyuLPgRU1LbY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=myAjLsXJJ5WrIyplttBLOJrb3cYFWSnfDJgomMmHBsY=;
        b=jcId3QkZBG7zuENMKN0yMefndAxECpiTEhQVYS8U6bVjcQXCOM1/WrfWN7IJ9Qh3jt
         s9XhvZfJ0SYRihYONgwflmig9ca/7JsgGPKrqcbxk8TetucYC3rz/8mQDA31L+1r7Mvz
         +aAiRtE3vNTGIc94JuvwxP0FUx2sp/cyKEwWlK0utwOyiQ4NU8sGaOLZtHGsjw6QSURM
         jBpiL6Gs7Hbyp3be1PdJICf+ojpXcc4HqozGhTOqrPrrdhsDBFSX5jXYLdznUnnq7mro
         JpU9IuI7v8vbpBTMKiCqafKqZT3GGx6ugWnTevhm6SpGPcn/ai3e3n74IiOJ09iiKJ9B
         d3DA==
X-Gm-Message-State: AOAM532LvpmrTAEa1BSuEQZuzkMIP8oDXMcZ+TDGfSSF/TKwpMe9wVzk
        q1JynVxzZpt/PSaM5PoLBAdEqpV+CXyhgQ==
X-Google-Smtp-Source: ABdhPJxM7CI6ObOTA/dAnpNqk4c7bPseM/evKd+pRwbVQYq3IOIRkOFgQb1ors7cvRWIw5JowuZv0w==
X-Received: by 2002:a17:90a:450d:: with SMTP id u13mr2718413pjg.99.1598986659307;
        Tue, 01 Sep 2020 11:57:39 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b10sm1613877pff.85.2020.09.01.11.57.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2020 11:57:38 -0700 (PDT)
Date:   Tue, 1 Sep 2020 11:57:37 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Michael Ellerman <mpe@ellerman.id.au>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH 05/10] lkdtm: disable set_fs-based tests for
 !CONFIG_SET_FS
Message-ID: <202009011156.0F49882@keescook>
References: <20200827150030.282762-1-hch@lst.de>
 <20200827150030.282762-6-hch@lst.de>
 <CAHk-=wipbWD66sU7etETXwDW5NRsU2vnbDpXXQ5i94hiTcawyw@mail.gmail.com>
 <20200829092406.GB8833@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200829092406.GB8833@lst.de>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Aug 29, 2020 at 11:24:06AM +0200, Christoph Hellwig wrote:
> On Thu, Aug 27, 2020 at 11:06:28AM -0700, Linus Torvalds wrote:
> > On Thu, Aug 27, 2020 at 8:00 AM Christoph Hellwig <hch@lst.de> wrote:
> > >
> > > Once we can't manipulate the address limit, we also can't test what
> > > happens when the manipulation is abused.
> > 
> > Just remove these tests entirely.
> > 
> > Once set_fs() doesn't exist on x86, the tests no longer make any sense
> > what-so-ever, because test coverage will be basically zero.
> > 
> > So don't make the code uglier just to maintain a fiction that
> > something is tested when it isn't really.
> 
> Sure fine with me unless Kees screams.

To clarify: if any of x86, arm64, arm, powerpc, riscv, and s390 are
using set_fs(), I want to keep this test. "ugly" is fine in lkdtm. :)

-- 
Kees Cook
