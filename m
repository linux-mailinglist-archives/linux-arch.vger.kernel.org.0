Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDC012A8C48
	for <lists+linux-arch@lfdr.de>; Fri,  6 Nov 2020 02:47:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731111AbgKFBr2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 5 Nov 2020 20:47:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730414AbgKFBr2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 5 Nov 2020 20:47:28 -0500
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03E90C0613CF;
        Thu,  5 Nov 2020 17:47:27 -0800 (PST)
Received: by mail-qv1-xf44.google.com with SMTP id g13so1724039qvu.1;
        Thu, 05 Nov 2020 17:47:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JR0Tzfuelh7U/ZSCF0gsQf2842GEU08B6XoxJ6an+SA=;
        b=Eus6+WehDQXRwrDUKM1V55RI4ZEp4fLXtbv6s3A20FrA1YaIS8/rwSjg+D9ZhkrSK4
         hXqkLSaK/7uirEnfX6TAV3B9++krAB17F/NlsLSVtTiEiQczSeWgUfW1gfuWJNHpnR/s
         Nv/3buePcvJjlK7OcZ74CmN/F4Mr618EkKUlB+2na8hQGi6wLA7wsQgAbgpWaiot9AD+
         OGG8ps0SdMaBMgG3aPWdAqH5dYdk0c7bcHS/goLmlckWUElGCyNow5CJFwaP+soCxwBb
         bFh0SE7wwDluNOe8vsUc7cs81mUPfWZilBgBmO5AhE8gsqDcg/dsErEMtbsADhsj85HA
         YoGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JR0Tzfuelh7U/ZSCF0gsQf2842GEU08B6XoxJ6an+SA=;
        b=fyOQL+TJHbBS3yrIzBDwA3vZ0rPOcn4EWG/ojOhzJndvIzSFI6sRGLIwUS8/szsi8G
         r+Sttd/+ZzfCEWiG9t6ilchIS3655d+wj0oAMY3LNFHQ2OfHsezw5KE9zAaph9mCQRAv
         TuioSEuDjbiA3QizsggrfVtFc5sgK7R2O3vXqKxwSB+OzdoWZ2uOKCL7PD0coo1TT+7K
         HROtKPnSndsyfOltAM+T4FMHcU7LPnTmV+IKGyiQREmRrJCFfP0+kpfZcXZPOiN1TTkC
         dV6/YE+X8UgJ64Ofj0fRuMfDFQh+WjHVFRJu89B9MstVpZvor9IsmAlgG51rlPYX+KyD
         tP9Q==
X-Gm-Message-State: AOAM530U5Pt/ElM1SHsWUjYi3qZ3q3CYPjc1N72/1ZOiWzQvMRMW7rlM
        g7n7hrPs7NnrmVUQrVI561k=
X-Google-Smtp-Source: ABdhPJyJN5SWDuAsLvQ32wEASK4WomrTqMQ5EawjDXUrOJRdtpi32YmTLY6VYC6kJ4wZ8tLRIp8YKg==
X-Received: by 2002:a0c:d6cb:: with SMTP id l11mr5240362qvi.9.1604627247232;
        Thu, 05 Nov 2020 17:47:27 -0800 (PST)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id g13sm2151330qth.27.2020.11.05.17.47.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Nov 2020 17:47:26 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailauth.nyi.internal (Postfix) with ESMTP id C7DFD27C0054;
        Thu,  5 Nov 2020 20:47:25 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 05 Nov 2020 20:47:25 -0500
X-ME-Sender: <xms:LKukXwHL9_xPbKHeJIAjzeMkm5SKGl1h77KCDBzDG3p-c4qfgIWG6w>
    <xme:LKukX5VxxqDs8OrACCnqHskP5pEC_iCtHNmOimgbx76lI4wy7jQR7TsWBrLMABNuI
    2gJ34yF2jknX0Z_vw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedruddtkedggedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesthdtre
    dttddtvdenucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehg
    mhgrihhlrdgtohhmqeenucggtffrrghtthgvrhhnpedvleeigedugfegveejhfejveeuve
    eiteejieekvdfgjeefudehfefhgfegvdegjeenucfkphepudefuddruddtjedrudegjedr
    uddvieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdei
    gedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfih
    igmhgvrdhnrghmvg
X-ME-Proxy: <xmx:LKukX6KSRqGDYI_xoK0Uk2QoZB1rVxPoV8nJzje6SIEIhAk8n7rM2Q>
    <xmx:LKukXyFnBQHR5J4KGoVv9A19YZd6BskM6UjMqpiEZkLGvY0FBhu0dQ>
    <xmx:LKukX2VTpDYpwmvqH-JPsXKYUn5XSzxOZYM-UdGrW1jnryW9laTbfg>
    <xmx:LaukX3tkEgaQ7pIDam0C6oCL2rmaYWxn7cWRflaVRsv3WmHyoHKYG_1WxEA>
Received: from localhost (unknown [131.107.147.126])
        by mail.messagingengine.com (Postfix) with ESMTPA id 5863F3060064;
        Thu,  5 Nov 2020 20:47:24 -0500 (EST)
Date:   Fri, 6 Nov 2020 09:47:22 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     paulmck@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org, stern@rowland.harvard.edu,
        parri.andrea@gmail.com, will@kernel.org, peterz@infradead.org,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, akiyks@gmail.com
Subject: Re: [PATCH memory-model 5/8] tools/memory-model: Add a glossary of
 LKMM terms
Message-ID: <20201106014722.GB3025@boqun-archlinux>
References: <20201105215953.GA15309@paulmck-ThinkPad-P72>
 <20201105220017.15410-5-paulmck@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201105220017.15410-5-paulmck@kernel.org>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Nov 05, 2020 at 02:00:14PM -0800, paulmck@kernel.org wrote:
> From: "Paul E. McKenney" <paulmck@kernel.org>
> 
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> ---
>  tools/memory-model/Documentation/glossary.txt | 155 ++++++++++++++++++++++++++
>  1 file changed, 155 insertions(+)
>  create mode 100644 tools/memory-model/Documentation/glossary.txt
> 
> diff --git a/tools/memory-model/Documentation/glossary.txt b/tools/memory-model/Documentation/glossary.txt
> new file mode 100644
> index 0000000..036fa28
> --- /dev/null
> +++ b/tools/memory-model/Documentation/glossary.txt
> @@ -0,0 +1,155 @@
> +This document contains brief definitions of LKMM-related terms.  Like most
> +glossaries, it is not intended to be read front to back (except perhaps
> +as a way of confirming a diagnosis of OCD), but rather to be searched
> +for specific terms.
> +
> +
> +Address Dependency:  When the address of a later memory access is computed
> +	based on the value returned by an earlier load, an "address
> +	dependency" extends from that load extending to the later access.
> +	Address dependencies are quite common in RCU read-side critical
> +	sections:
> +
> +	 1 rcu_read_lock();
> +	 2 p = rcu_dereference(gp);
> +	 3 do_something(p->a);
> +	 4 rcu_read_unlock();
> +
> +	 In this case, because the address of "p->a" on line 3 is computed
> +	 from the value returned by the rcu_dereference() on line 2, the
> +	 address dependency extends from that rcu_dereference() to that
> +	 "p->a".  In rare cases, optimizing compilers can destroy address
> +	 dependencies.	Please see Documentation/RCU/rcu_dereference.txt
> +	 for more information.
> +
> +	 See also "Control Dependency".
> +
> +Acquire:  With respect to a lock, acquiring that lock, for example,
> +	using spin_lock().  With respect to a non-lock shared variable,
> +	a special operation that includes a load and which orders that
> +	load before later memory references running on that same CPU.
> +	An example special acquire operation is smp_load_acquire(),
> +	but atomic_read_acquire() and atomic_xchg_acquire() also include
> +	acquire loads.
> +
> +	When an acquire load returns the value stored by a release store
> +	to that same variable, then all operations preceding that store

Change this to:

	When an acquire load reads-from a release store

, and put a reference to "Reads-from"? I think this makes the document
more consistent in that it makes clear "an acquire load returns the
value stored by a release store to the same variable" is not a special
case, it's simple a "Reads-from".

> +	happen before any operations following that load acquire.

Add a reference to the definition of "happen before" in explanation.txt?

Regards,
Boqun

> +
> +	See also "Relaxed" and "Release".
> +
[...]
