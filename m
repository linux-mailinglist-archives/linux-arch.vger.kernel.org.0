Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 529A515D3AC
	for <lists+linux-arch@lfdr.de>; Fri, 14 Feb 2020 09:18:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728783AbgBNISd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 14 Feb 2020 03:18:33 -0500
Received: from mail-wr1-f48.google.com ([209.85.221.48]:45297 "EHLO
        mail-wr1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726049AbgBNISc (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 14 Feb 2020 03:18:32 -0500
Received: by mail-wr1-f48.google.com with SMTP id g3so9819684wrs.12;
        Fri, 14 Feb 2020 00:18:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vSXazn/0l3CmxT7zcelHW+dDQ5NLtkBXf9Ciiz1D/AA=;
        b=cwpWqXTX1qjbMbz3GZURmSN1fuk1y4lrzbBeL4NCgnwdw02ObXHrJt9KQ9m2fKVXJJ
         h9TvTk4S0GP+8RiC/Ncgucwe/vQiWDy+ccu2Dtl3tb4FzI7aPkr87ioe7b0LiHKUT/Oi
         255Ppjgs7uFa6P4CE1kfjd4lY02gVH3qU7pwejMyaBupa1lQR5nO8+9kYFpowjN+uCmd
         DpEXCIx4Fl4slhHEgTVNfw8MKRynkYTRnCO/2/4M13hRR9FswJyUGMauuxvZryEvOl0J
         9kkTVNehOk2ri7rCBghM+ITNrD6P9k8Fen1oinplgDLdoFlh0cZOd6WlSqZxw2wzO7At
         Qg/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vSXazn/0l3CmxT7zcelHW+dDQ5NLtkBXf9Ciiz1D/AA=;
        b=O4Lu1mJM+Ve1MM1fYJvlrtJiPCUPAvjN6jr7damP0ewafrwCzlli7u+V0dxZGQn26U
         bmuW63zxC96/eLPBD+DtCj+cj2rkUvYHe0VF5wT/vTAFIlPrQZuIpxA63A9QCJPqtMeA
         VpxCKaf/phVfpTsyxegn/SlZyqDEaBfg7a5VBcSd2qLo3HceRK6eoK/ouqQlsAXym0gF
         P8wYZxl3/heA76D5wdkOrPvOLkWCNpgxw4PZNWJvhTY7z9ZtpZrMrhRvIFXhjqVk0Gi9
         bih2ny9GYv9ZjfRTokAODDLsK6wBEICnSCCx3UloGxs1LUsHPA1rp4UMGqyKwW97J/So
         Y87w==
X-Gm-Message-State: APjAAAVnQtkOfvZqUpZ1eDv0TPmvSRzWXe/47Ulz/W8PKu2OoBOWTzzZ
        oyDsyh9jzjVHGvZo2NUmTmE=
X-Google-Smtp-Source: APXvYqzYwC9g81y1hCiT2QGfAP0a7rVizLAR7LOILnHW5zfWkqoTJigivABDlqvkaAb68OkVo/SFaQ==
X-Received: by 2002:adf:e70d:: with SMTP id c13mr2618482wrm.248.1581668309665;
        Fri, 14 Feb 2020 00:18:29 -0800 (PST)
Received: from andrea (ip-213-220-200-127.net.upcbroadband.cz. [213.220.200.127])
        by smtp.gmail.com with ESMTPSA id b11sm6311466wrx.89.2020.02.14.00.18.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2020 00:18:29 -0800 (PST)
Date:   Fri, 14 Feb 2020 09:18:26 +0100
From:   Andrea Parri <parri.andrea@gmail.com>
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Alan Stern <stern@rowland.harvard.edu>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-arch@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [RFC 3/3] tools/memory-model: Add litmus test for RMW +
 smp_mb__after_atomic()
Message-ID: <20200214081826.GB17708@andrea>
References: <20200214040132.91934-1-boqun.feng@gmail.com>
 <20200214040132.91934-4-boqun.feng@gmail.com>
 <20200214061537.GA20408@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200214061537.GA20408@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

> > @@ -0,0 +1,29 @@
> > +C Atomic-RMW+mb__after_atomic-is-strong-acquire
> > +
> > +(*
> > + * Result: Never
> > + *
> > + * Test of an atomic RMW followed by a smp_mb__after_atomic() is
> > + * "strong-acquire": both the read and write part of the RMW is ordered before
> > + * the subsequential memory accesses.
> > + *)
> > +
> > +{
> > +}
> > +
> > +P0(int *x, atomic_t *y)
> > +{
> > +	r0 = READ_ONCE(*x);
> > +	smp_rmb();
> > +	r1 = atomic_read(y);

IIRC, klitmus7 needs a declaration for these local variables, say
(trying to keep herd7 happy):

P0(int *x, atomic_t *y)
{
	int r0;
	int r1;

	r0 = READ_ONCE(*x);
	smp_rmb();
	r1 = atomic_read(y);
}

Thanks,
  Andrea
