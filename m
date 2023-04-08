Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C98A6DBC36
	for <lists+linux-arch@lfdr.de>; Sat,  8 Apr 2023 18:50:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229494AbjDHQuC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 8 Apr 2023 12:50:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjDHQuA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 8 Apr 2023 12:50:00 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F0B0173C
        for <linux-arch@vger.kernel.org>; Sat,  8 Apr 2023 09:49:58 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id ly9so4312780qvb.5
        for <linux-arch@vger.kernel.org>; Sat, 08 Apr 2023 09:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1680972597;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ijfgt0VBpcFp7S3FT0E/4pyBptFK+Ct1rfgc4iMqxiM=;
        b=WH0bfYgfWpdorK2UK87FfXUeNxDZvFxty6Rg7smG5Ec1ssKELrPFfhaQJjz1nMNxte
         AYh9Ek7hA5g+7bQn8m1CKjjKzoXsJE9sHNAsdDb0IQ0eG5y/k4DGf3jGD8buV21Iaj8d
         qJxo3LDd2scQkV9VXwwWB2xu/xVznjjlp1gsk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680972597;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ijfgt0VBpcFp7S3FT0E/4pyBptFK+Ct1rfgc4iMqxiM=;
        b=Y6cCAcB3aTv/LxgFL6WyCq4w7sBVr0hs89KxAr4IvbuXBNNOhEy73vb3GfKgex/Y6K
         NZpuDFRDqqt2IbJ5uvNAz5EnxO3p+8/cRLbUWH2mhbjKjeF4TMD9glQhizOGpXO1D+1P
         4HjYZ0hHA2OrwmyS9md73stnfbc7drFhsoYMFKOUF/F0V9cdQCgGyUEAd0uq1VfkACFS
         fp5d7e7iaCfBXJ/34c7K+d6pMjH7mAdOhXZxjkHfP7t+TzAP8sUlTOj1cOvy14FLV0Xn
         JUzi7Kfuv0XUT0hDngX0s+jWCaBqxQ0U7LuB5hVdt+hcoz4QaoZwutsiZ19Fa9w0sfom
         u+XQ==
X-Gm-Message-State: AAQBX9eYd16Y3YwDgA1ft9XG4OBZzzgSpctWrR4wbMJTKVO8PB3xh1F2
        azJubqIhGXPagUyiEy/PlKBTPg==
X-Google-Smtp-Source: AKy350Yj+fH9S1xMyqxeEOlrJXqxLhtyKl+FGK8O3k9IGrvd9ZXAVJ4vACVr8+4Bm51YTlfnm+E7nQ==
X-Received: by 2002:a05:6214:252c:b0:5ea:5948:8ee2 with SMTP id gg12-20020a056214252c00b005ea59488ee2mr1261129qvb.33.1680972597546;
        Sat, 08 Apr 2023 09:49:57 -0700 (PDT)
Received: from localhost (129.239.188.35.bc.googleusercontent.com. [35.188.239.129])
        by smtp.gmail.com with ESMTPSA id i11-20020a056214020b00b005dd8b9345a6sm2148911qvt.62.2023.04.08.09.49.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Apr 2023 09:49:56 -0700 (PDT)
Date:   Sat, 8 Apr 2023 16:49:56 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        linux-kernel@vger.kernel.org, Boqun Feng <boqun.feng@gmail.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Akira Yokosawa <akiyks@gmail.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        David Howells <dhowells@redhat.com>,
        Jonas Oberhauser <jonas.oberhauser@huawei.com>,
        linux-arch@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>,
        Paul =?iso-8859-1?Q?Heidekr=FCger?= <paul.heidekrueger@in.tum.de>,
        Will Deacon <will@kernel.org>
Subject: Re: Litmus test names
Message-ID: <20230408164956.GA680332@google.com>
References: <ea9376b4-4b3d-48ee-9c27-ad8de8a7b5cb@paulmck-laptop>
 <3908932E-17D4-4B87-AB0C-D10564F10623@joelfernandes.org>
 <159545c3-0093-3cbd-e822-7298ae764966@huaweicloud.com>
 <d32901a8-3a07-440c-9089-36b37c3f04e5@paulmck-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d32901a8-3a07-440c-9089-36b37c3f04e5@paulmck-laptop>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Apr 07, 2023 at 05:49:02PM -0700, Paul E. McKenney wrote:
> On Fri, Apr 07, 2023 at 03:05:01PM +0200, Jonas Oberhauser wrote:
> > 
> > 
> > On 4/7/2023 2:12 AM, Joel Fernandes wrote:
> > > 
> > > 
> > > > On Apr 6, 2023, at 6:34 PM, Paul E. McKenney <paulmck@kernel.org> wrote:
> > > > 
> > > > ﻿On Thu, Apr 06, 2023 at 05:36:13PM -0400, Alan Stern wrote:
> > > > > Paul:
> > > > > 
> > > > > I just saw that two of the files in
> > > > > tools/memory-model/litmus-tests have
> > > > > almost identical names:
> > > > > 
> > > > >  Z6.0+pooncelock+pooncelock+pombonce.litmus
> > > > >  Z6.0+pooncelock+poonceLock+pombonce.litmus
> > > > > 
> > > > > They differ only by a lower-case 'l' vs. a capital 'L'.  It's
> > > > > not at all
> > > > > easy to see, and won't play well in case-insensitive filesystems.
> > > > > 
> > > > > Should one of them be renamed?
> > > > 
> > > > Quite possibly!
> > > > 
> > > > The "L" denotes smp_mb__after_spinlock().  The only code difference
> > > > between these is that Z6.0+pooncelock+poonceLock+pombonce.litmus has
> > > > smp_mb__after_spinlock() and Z6.0+pooncelock+pooncelock+pombonce.litmus
> > > > does not.
> > > > 
> > > > Suggestions for a better name?  We could capitalize all the letters
> > > > in LOCK, I suppose...
> > 
> > I don't think capitalizing LOCK is helpful.
> 
> Greek font, then?  (Sorry, couldn't resist...)
> 
> > To be honest, almost all the names are extremely cryptic to newcomers like
> > me (like, what does Z6.0 mean? Is it some magic incantation?).
> > And that's not something that's easy to fix.
> 
> All too true on all counts.  Some of the names abbreviate the litmus
> test itself, and there are multiple encodings depending one who/what
> generated the test in question.  Others of the names relate to who came
> up with them or the code from which they are derived.
> 
> New allegedly universal naming schemes have a rather short half-life.
> 
> What would be cool would be a way to structurally compare litmus tests.
> I bet that there are quite a few duplicates, for example.
> 
> > The only use case I can think of for spending time improving the names is
> > that sometimes you wanna say something like "oh, this is like
> > Z6.0+pooncelock+pooncelockmb+pombonce". And then people can look up what
> > that is.
> > For that, it's important that the names are easy to disambiguate by humans,
> > and I think Joel's suggestion is an improvement.
> > (and it also fixes the issue brought up by Alan about case-insensitive file
> > systems)
> > 
> > > 
> > > Z6.0+pooncelock+pooncelockmb+pombonce.litmus ?
> 
> I am OK with this one, but then again, I was also OK with the original
> Z6.0+pooncelock+poonceLock+pombonce.litmus.  ;-)

FWIW, if I move that smp_mb_after..() a step lower, that also makes the test
work (see below).

If you may look over quickly my analysis of why this smp_mb_after..() is
needed, it is because what I marked as a and d below don't have an hb
relation right?

(*
  b ->rf c

  d ->co e

  e ->hb f

  basically the issue is a ->po b ->rf c ->po d    does not imply a ->hb d
*)

P0(int *x, int *y, spinlock_t *mylock)
{
	spin_lock(mylock);
	WRITE_ONCE(*x, 1); // a
	WRITE_ONCE(*y, 1); // b
	spin_unlock(mylock);
}

P1(int *y, int *z, spinlock_t *mylock)
{
	int r0;

	spin_lock(mylock);
	r0 = READ_ONCE(*y); // c
	smp_mb__after_spinlock(); // moving this a bit lower also works fwiw.
	WRITE_ONCE(*z, 1);  // d
	spin_unlock(mylock);
}

P2(int *x, int *z)
{
	int r1;

	WRITE_ONCE(*z, 2);  // e
	smp_mb();
	r1 = READ_ONCE(*x); // f
}

exists (1:r0=1 /\ z=2 /\ 2:r1=0)


> Would someone like to to a "git mv" send the resulting patch?

Yes I can do that in return as I am thankful in advance for the above
discussion. ;)

thanks,

 - Joel

