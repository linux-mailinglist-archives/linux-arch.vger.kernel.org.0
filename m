Return-Path: <linux-arch+bounces-4954-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FADB90BF56
	for <lists+linux-arch@lfdr.de>; Tue, 18 Jun 2024 00:54:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBEF5280EB4
	for <lists+linux-arch@lfdr.de>; Mon, 17 Jun 2024 22:53:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABACC19069C;
	Mon, 17 Jun 2024 22:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PI4DpMKR"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECC4C28FC;
	Mon, 17 Jun 2024 22:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718664836; cv=none; b=Mn5bGZkfB1Nq7TsaUH+VptW8dcNTkPJpa/5Nu//1aTFUatQXD+mE1bECkhjZncxjU78rZq4GMXWH2cRsQN0qd/jQQIhDVuCi+mgD9nl2eBxRBY/PmixSb1Bf6u03lmD5Uqyc51mM+z3foB9XsVwUsrJyid8aet7GGAwPNDV8Yhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718664836; c=relaxed/simple;
	bh=TjHTdroRoR5PgBU+QKggAmEjD+Fm0zizybQ8OUedwA0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SqYt0ApkN/SIK5EMzHhsNBOGUErBxaBQp1G9O6mhY+Zn9ab3OgOptm2nUMrE4JblN0xf14eWc6gcH5cdoYsD8LPMnIz2p/dzLxabQh4PmY3mA4BTICna+1UA/GyPHBmF9Zh+1L19ySDb1lAFLuQVhx/hnM2i6C5vc4kdlYsccNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PI4DpMKR; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-df481bf6680so5237848276.3;
        Mon, 17 Jun 2024 15:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718664834; x=1719269634; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tFosb9YDdf4M17cTyH2qFik92uDQDBc6ij6WR+HWwM0=;
        b=PI4DpMKRT5YLASZB/1M/ngpKgb8uv6iqrJ7nuYLNDtSZYmfYZ4IBa4ezjYfTR5sH2J
         uCdUaLA1FpXyKk3uTX2jQoVZN8jtwdO/EAN6KZijhpx8X5YwyiqBSj6hm3afMu/6vaRy
         HjwQMWTtpcLlnnMIUH7P4Q1ZKT6skbSWiawt3NYjr3BZiDJjRPIlQiU7GISCvTtN2c83
         hILJANcLAWLZ1qYqA0dFW5r5MkxbRy5WmteL8l5qDWvDtkc26GpwafMjsUb0VF8elxO0
         Nh3SwhfGmwpvUTtqvPEuitBqS09FFMmrXFJ+JmQrpDdKwiMVucv4rB7SS2JzozbhnTgK
         9fjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718664834; x=1719269634;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tFosb9YDdf4M17cTyH2qFik92uDQDBc6ij6WR+HWwM0=;
        b=YDBF2ZsOh8jRqdjtYkD9MHKqmU65PM5VtzXoEh2XWB4r3ACl6HFt3ewzMuDkhOxfi1
         TWtWz9z/+1zoM8hiB9VjU3AgjcEpnhBOMxVuwlbdvC/4SjGQmHzTydVSz//0R55oXpyg
         VjGSuNn3h0pB7XuxAMkxYkndI/PRXr8squPWzALyP4O4a7gZ6yydukuwlkJLTSpeaCpm
         S14JoA2gHG2q/PK56ELYLxSh3b83qWwiwFw/RPlc3iIt7fdwAULqzjb0TXElPFYU0nnT
         OMnA949SKNBWVrZZz3uzu3RgTZQQ54KeVp38AYfE4p2OthIFHNXd32yEZLyo7SgAdbRJ
         vUBA==
X-Forwarded-Encrypted: i=1; AJvYcCWYEeRH8m8wGhAxg/AHOX1K5DA4dfNRahEBmHhhG8DBhZTdgI6/kclDrogeF+CK4kKrolhwD19r27Xm+LqW4pz+1xCehNqYUIjVKV3FOIkxIIisiLUkTJlAxThq6/eoLbtij03l+NYi2Q==
X-Gm-Message-State: AOJu0Yx1GLps3OpW5zrlV5EGCtmyIQkzvMLYrzD+ycGRW/pqv+AH9GVq
	+kPGmt2iKDmGovUiOYcQbmJzt9ftreCGXT/ulNjm80docAyOseMMrGnHNw==
X-Google-Smtp-Source: AGHT+IH8zjzIk9uswMw8/4TTRjt9IHjAfcp/BlO5kZjnOiKgTthmxZXFmoxXmfACzUs0nxgpzbORmA==
X-Received: by 2002:a25:b110:0:b0:dfb:2084:1bc5 with SMTP id 3f1490d57ef6-dff15344ce2mr10676082276.6.1718664833790;
        Mon, 17 Jun 2024 15:53:53 -0700 (PDT)
Received: from fauth2-smtp.messagingengine.com (fauth2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b2a5c12836sm60377556d6.40.2024.06.17.15.53.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 15:53:52 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfauth.nyi.internal (Postfix) with ESMTP id CCE671200066;
	Mon, 17 Jun 2024 18:53:51 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 17 Jun 2024 18:53:51 -0400
X-ME-Sender: <xms:f75wZhEIgABQTLO8bNdwyHcnRoUgH2lSghudprwKBE09om2K-XVSpg>
    <xme:f75wZmXRZLMBsWq3Lf9y61hfiWOSn6h_Z4jyn8BpjcnDfGtEHHqMwCK3dJTdPBySO
    KSXBPleJCSi58MNUQ>
X-ME-Received: <xmr:f75wZjI-iow0u7VxifHh1KtQJxkISQiOPlcd65TWRX5U7bz4wYewgpgqsoy1CA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedviedgudehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpefhtedvgfdtueekvdekieetieetjeeihedvteehuddujedvkedtkeefgedv
    vdehtdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhh
    phgvrhhsohhnrghlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunh
    drfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:f75wZnHTuAHWNGSopSD5W3CvSjxhurdOfSnH80gdp15ddnxTj6lthQ>
    <xmx:f75wZnVRGfD3KVeLmqV_1o4eX8XnVahz_I79LmPvHlwi-bOC8AYD5w>
    <xmx:f75wZiNpuQi2OScMUajC8MV-tibq6H58i_vfCM9umSblibh23KERvQ>
    <xmx:f75wZm3HSAQOvpqhwqf0Xl2Gi6BRH4UYwdTGjmrVhiBd0n0QCscraQ>
    <xmx:f75wZkWkVZ3jGbFOTF98yH-ZL9WqmZI7Xi8ptooIQtUgxcd84fpibKUH>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 17 Jun 2024 18:53:51 -0400 (EDT)
Date: Mon, 17 Jun 2024 15:53:38 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Andrea Parri <parri.andrea@gmail.com>
Cc: stern@rowland.harvard.edu, will@kernel.org, peterz@infradead.org,
	npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
	luc.maranget@inria.fr, paulmck@kernel.org, akiyks@gmail.com,
	dlustig@nvidia.com, joel@joelfernandes.org,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	hernan.poncedeleon@huaweicloud.com,
	jonas.oberhauser@huaweicloud.com
Subject: Re: [PATCH v3] tools/memory-model: Document herd7 (abstract)
 representation
Message-ID: <ZnC-cqQOEU2fd9tO@boqun-archlinux>
References: <20240617201759.1670994-1-parri.andrea@gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240617201759.1670994-1-parri.andrea@gmail.com>

On Mon, Jun 17, 2024 at 10:17:59PM +0200, Andrea Parri wrote:
> tools/memory-model/ and herdtool7 are closely linked: the latter is
> responsible for (pre)processing each C-like macro of a litmus test,
> and for providing the LKMM with a set of events, or "representation",
> corresponding to the given macro.  Provide herd-representation.txt
> to document the representations of the concurrency macros, following
> their "classification" in Documentation/atomic_t.txt.
> 
> Suggested-by: Hernan Ponce de Leon <hernan.poncedeleon@huaweicloud.com>
> Signed-off-by: Andrea Parri <parri.andrea@gmail.com>

Reviewed-by: Boqun Feng <boqun.feng@gmail.com>

I have a question below...

> ---
> Changes since v2 [1]:
>   - drop lk-rmw links
> 
> Changes since v1 [2]:
>   - add legenda/notations
>   - add some SRCU, locking macros
>   - update formatting of failure cases
>   - update README file
> 
> [1] https://lore.kernel.org/lkml/20240605134918.365579-1-parri.andrea@gmail.com/
> [2] https://lore.kernel.org/lkml/20240524151356.236071-1-parri.andrea@gmail.com/
> 
>  tools/memory-model/Documentation/README       |   7 +-
>  .../Documentation/herd-representation.txt     | 106 ++++++++++++++++++
>  2 files changed, 112 insertions(+), 1 deletion(-)
>  create mode 100644 tools/memory-model/Documentation/herd-representation.txt
> 
> diff --git a/tools/memory-model/Documentation/README b/tools/memory-model/Documentation/README
> index 304162743a5b8..44e7dae73b296 100644
> --- a/tools/memory-model/Documentation/README
> +++ b/tools/memory-model/Documentation/README
> @@ -33,7 +33,8 @@ o	You are familiar with Linux-kernel concurrency and the use of
>  
>  o	You are familiar with Linux-kernel concurrency and the use
>  	of LKMM, and would like to learn about LKMM's requirements,
> -	rationale, and implementation:	explanation.txt
> +	rationale, and implementation:	explanation.txt and
> +	herd-representation.txt
>  
>  o	You are interested in the publications related to LKMM, including
>  	hardware manuals, academic literature, standards-committee
> @@ -61,6 +62,10 @@ control-dependencies.txt
>  explanation.txt
>  	Detailed description of the memory model.
>  
> +herd-representation.txt
> +	The (abstract) representation of the Linux-kernel concurrency
> +	primitives in terms of events.
> +
>  litmus-tests.txt
>  	The format, features, capabilities, and limitations of the litmus
>  	tests that LKMM can evaluate.
> diff --git a/tools/memory-model/Documentation/herd-representation.txt b/tools/memory-model/Documentation/herd-representation.txt
> new file mode 100644
> index 0000000000000..2fe270e902635
> --- /dev/null
> +++ b/tools/memory-model/Documentation/herd-representation.txt
> @@ -0,0 +1,106 @@
> +#
> +# Legenda:
> +#	R,	a Load event
> +#	W,	a Store event
> +#	F,	a Fence event
> +#	LKR,	a Lock-Read event
> +#	LKW,	a Lock-Write event
> +#	UL,	an Unlock event
> +#	LF,	a Lock-Fail event
> +#	RL,	a Read-Locked event
> +#	RU,	a Read-Unlocked event
> +#	R*,	a Load event included in RMW
> +#	W*,	a Store event included in RMW
> +#	SRCU,	a Sleepable-Read-Copy-Update event
> +#
> +#	po,	a Program-Order link
> +#	rmw,	a Read-Modify-Write link
> +#
> +# By convention, a blank entry/representation means "same as the preceding entry".
> +#
> +    ------------------------------------------------------------------------------
> +    |                        C macro | Events                                    |
> +    ------------------------------------------------------------------------------
> +    |                    Non-RMW ops |                                           |
> +    ------------------------------------------------------------------------------
> +    |                      READ_ONCE | R[once]                                   |
> +    |                    atomic_read |                                           |
> +    |                     WRITE_ONCE | W[once]                                   |
> +    |                     atomic_set |                                           |
> +    |               smp_load_acquire | R[acquire]                                |
> +    |            atomic_read_acquire |                                           |
> +    |              smp_store_release | W[release]                                |
> +    |             atomic_set_release |                                           |
> +    |                   smp_store_mb | W[once] ->po F[mb]                        |
> +    |                         smp_mb | F[mb]                                     |
> +    |                        smp_rmb | F[rmb]                                    |
> +    |                        smp_wmb | F[wmb]                                    |
> +    |          smp_mb__before_atomic | F[before-atomic]                          |
> +    |           smp_mb__after_atomic | F[after-atomic]                           |
> +    |                    spin_unlock | UL                                        |
> +    |                 spin_is_locked | On success: RL                            |
> +    |                                | On failure: RU                            |
> +    |         smp_mb__after_spinlock | F[after-spinlock]                         |
> +    |      smp_mb__after_unlock_lock | F[after-unlock-lock]                      |
> +    |                  rcu_read_lock | F[rcu-lock]                               |
> +    |                rcu_read_unlock | F[rcu-unlock]                             |
> +    |                synchronize_rcu | F[sync-rcu]                               |
> +    |                rcu_dereference | R[once]                                   |
> +    |             rcu_assign_pointer | W[release]                                |
> +    |                 srcu_read_lock | R[srcu-lock]                              |
> +    |                 srcu_down_read |                                           |
> +    |               srcu_read_unlock | W[srcu-unlock]                            |
> +    |                   srcu_up_read |                                           |
> +    |               synchronize_srcu | SRCU[sync-srcu]                           |
> +    | smp_mb__after_srcu_read_unlock | F[after-srcu-read-unlock]                 |
> +    ------------------------------------------------------------------------------
> +    |       RMW ops w/o return value |                                           |
> +    ------------------------------------------------------------------------------
> +    |                     atomic_add | R*[noreturn] ->rmw W*[once]               |
> +    |                     atomic_and |                                           |
> +    |                      spin_lock | LKR ->po LKW                              |
> +    ------------------------------------------------------------------------------
> +    |        RMW ops w/ return value |                                           |
> +    ------------------------------------------------------------------------------
> +    |              atomic_add_return | F[mb] ->po R*[once]                       |
> +    |                                |     ->rmw W*[once] ->po F[mb]             |

Just to double check, there is also a ->po relation between R*[once] and
W*[once], right? It might not be important right now, but it's important
when we move to what Jonas is proposing:

	https://lore.kernel.org/lkml/20240604152922.495908-1-jonas.oberhauser@huaweicloud.com/
	
So just check with you ;-) Thanks!

Regards,
Boqun

> +    |               atomic_fetch_add |                                           |
> +    |               atomic_fetch_and |                                           |
> +    |                    atomic_xchg |                                           |
> +    |                           xchg |                                           |
> +    |            atomic_add_negative |                                           |
> +    |      atomic_add_return_relaxed | R*[once] ->rmw W*[once]                   |
> +    |       atomic_fetch_add_relaxed |                                           |
> +    |       atomic_fetch_and_relaxed |                                           |
> +    |            atomic_xchg_relaxed |                                           |
> +    |                   xchg_relaxed |                                           |
> +    |    atomic_add_negative_relaxed |                                           |
> +    |      atomic_add_return_acquire | R*[acquire] ->rmw W*[once]                |
> +    |       atomic_fetch_add_acquire |                                           |
> +    |       atomic_fetch_and_acquire |                                           |
> +    |            atomic_xchg_acquire |                                           |
> +    |                   xchg_acquire |                                           |
> +    |    atomic_add_negative_acquire |                                           |
> +    |      atomic_add_return_release | R*[once] ->rmw W*[release]                |
> +    |       atomic_fetch_add_release |                                           |
> +    |       atomic_fetch_and_release |                                           |
> +    |            atomic_xchg_release |                                           |
> +    |                   xchg_release |                                           |
> +    |    atomic_add_negative_release |                                           |
> +    ------------------------------------------------------------------------------
> +    |            Conditional RMW ops |                                           |
> +    ------------------------------------------------------------------------------
> +    |                 atomic_cmpxchg | On success: F[mb] ->po R*[once]           |
> +    |                                |                 ->rmw W*[once] ->po F[mb] |
> +    |                                | On failure: R*[once]                      |
> +    |                        cmpxchg |                                           |
> +    |              atomic_add_unless |                                           |
> +    |         atomic_cmpxchg_relaxed | On success: R*[once] ->rmw W*[once]       |
> +    |                                | On failure: R*[once]                      |
> +    |         atomic_cmpxchg_acquire | On success: R*[acquire] ->rmw W*[once]    |
> +    |                                | On failure: R*[once]                      |
> +    |         atomic_cmpxchg_release | On success: R*[once] ->rmw W*[release]    |
> +    |                                | On failure: R*[once]                      |
> +    |                   spin_trylock | On success: LKR ->po LKW                  |
> +    |                                | On failure: LF                            |
> +    ------------------------------------------------------------------------------
> -- 
> 2.34.1
> 

