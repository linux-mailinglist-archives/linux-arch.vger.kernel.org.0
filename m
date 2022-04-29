Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A592251552F
	for <lists+linux-arch@lfdr.de>; Fri, 29 Apr 2022 22:09:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234386AbiD2UMb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 29 Apr 2022 16:12:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232708AbiD2UMb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 29 Apr 2022 16:12:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 976348E1B8
        for <linux-arch@vger.kernel.org>; Fri, 29 Apr 2022 13:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651262951;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=94a8sGRLCWduCHgjo1sU1o0PAADf7AEfjaAegT1GkVY=;
        b=aEd1zHEUZRd2kd/fp8pFXgfjduWy5jRD9gzEzMDQMyYWuC33txx5WuPjQkk3HdT+rH3CiT
        vq/krfDrMJx+mGe+P0uV0sAq4b0aC3CGABi7qPe7aakWb3gtuCPiJLAezlX3kcUSrb9Xk3
        3VfMMFcke6r5ObBiS+H4KN7XL+5tgw8=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-448-2PyYlUa1PtSt28fXGnMg4w-1; Fri, 29 Apr 2022 16:09:10 -0400
X-MC-Unique: 2PyYlUa1PtSt28fXGnMg4w-1
Received: by mail-qv1-f70.google.com with SMTP id kk23-20020a056214509700b004542af238feso6714309qvb.19
        for <linux-arch@vger.kernel.org>; Fri, 29 Apr 2022 13:09:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=94a8sGRLCWduCHgjo1sU1o0PAADf7AEfjaAegT1GkVY=;
        b=Yv8H47QynxwAq3LC6XdCv5BojXLZpKFdtEcdlHwOtbKALz3hm+1stJBTc5WRK8X8H6
         JNYRVrBVH4cWZnwdz5J+EHcunDYRUBZ664ocGWqJK0JdL6FHDrJCOps0ch7MfGFyR9MP
         6cXlhds2S3XeItYVabm8GfdD4HAdtLwbIkWqJTxkRRBjkL0tU/f7Gx/D8GyQiNJZHCZb
         x8RI6BYl20J5RtV2aqbBS5Z6Ju0O3DKfoRB2xk8KQE8w4SYKEslZzzWJqD8rTFFUfYyK
         dFmOKgYBmDsJeXYFT0O0ZtULy2zNm6f7RO1B4kijJAvRMNvTMDbSSb9uXCe5wjgmqrhw
         AfCg==
X-Gm-Message-State: AOAM533vDAgH6ynWodWS48X1rrLY0ouc0EiVWwsi4V5ZLgWUuS9EPEZj
        HCXqNhoce1nkHZb1CQ6xx1YzYon9HBehCZDr7VUD19/5e3ohVCotajiQem3ByZ7w5koaFbc1YhX
        aN/K65CJUXxsQrv5df2BvOg==
X-Received: by 2002:a05:622a:34c:b0:2f3:94ee:b208 with SMTP id r12-20020a05622a034c00b002f394eeb208mr1033816qtw.132.1651262950001;
        Fri, 29 Apr 2022 13:09:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwCVWUepBF/5vP2n4C2hA4tRLUq8hCupOc+/Qlv6mn0fUg0kxKZ2bvjnx8BTfugNgXoVKPi4w==
X-Received: by 2002:a05:622a:34c:b0:2f3:94ee:b208 with SMTP id r12-20020a05622a034c00b002f394eeb208mr1033783qtw.132.1651262949762;
        Fri, 29 Apr 2022 13:09:09 -0700 (PDT)
Received: from treble ([2600:1700:6e32:6c00::15])
        by smtp.gmail.com with ESMTPSA id y62-20020a376441000000b0069fc13ce1ddsm79116qkb.14.2022.04.29.13.09.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 13:09:09 -0700 (PDT)
Date:   Fri, 29 Apr 2022 13:09:05 -0700
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Chen Zhongjin <chenzhongjin@huawei.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arch@vger.kernel.org, jthierry@redhat.com,
        catalin.marinas@arm.com, will@kernel.org, masahiroy@kernel.org,
        ycote@redhat.com, herbert@gondor.apana.org.au,
        mark.rutland@arm.com, davem@davemloft.net, ardb@kernel.org,
        maz@kernel.org, tglx@linutronix.de, luc.vanoostenryck@gmail.com
Subject: Re: [RFC PATCH v4 25/37] arm64: bpf: Skip validation of
 ___bpf_prog_run
Message-ID: <20220429200905.yjwxorrkd4u5rdmn@treble>
References: <20220429094355.122389-1-chenzhongjin@huawei.com>
 <20220429094355.122389-26-chenzhongjin@huawei.com>
 <YmvIZG5Ke6vElb/e@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YmvIZG5Ke6vElb/e@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Apr 29, 2022 at 01:13:40PM +0200, Peter Zijlstra wrote:
> On Fri, Apr 29, 2022 at 05:43:43PM +0800, Chen Zhongjin wrote:
> > There is a jump table encoded in ___bpf_prog_run and objtool-arm64
> > can't deal with it now. Skip validate it for arm64.
> 
> But, but, but, an earlier patch did -fno-jump-tables!

IIRC, -fno-jump-tables is specific to switch statements but this
function has a C-implemented jump table.

-- 
Josh

