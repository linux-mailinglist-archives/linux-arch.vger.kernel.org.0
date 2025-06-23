Return-Path: <linux-arch+bounces-12427-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B96C9AE33C1
	for <lists+linux-arch@lfdr.de>; Mon, 23 Jun 2025 04:48:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57D9A188F746
	for <lists+linux-arch@lfdr.de>; Mon, 23 Jun 2025 02:48:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B334019F121;
	Mon, 23 Jun 2025 02:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RmVYrbrD"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F7D184524;
	Mon, 23 Jun 2025 02:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750646895; cv=none; b=jePLLaUk07PAkPcFdmFMsYfh2qgD/UvJkHamtOEqpd63iZrfJHxUXGJWX+QRkC77rrMqNNU+HBXTaexreeteRxtU12ULC1oglR5WnyTG9FYKodghlP23sVJZaJY1Nmth6RM6GZgar8biLIiySJQJluo24xyF6ffXuTT3YRComZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750646895; c=relaxed/simple;
	bh=9yVcyJBRJnRpt1iF81CbrRUu+UUHjwSxXynZSJdXxrw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KKbpSCJcQ9BA3toSEuk+rnL1WKMqU4bT6z3qMkK/R3OapK3dhNQYvDjxE+7q4AGUqTpFGoS2yZwIo2kVtQBcG8LH9TNphzREl5zsTjDvuA0SrL2RXHOYeD0hSuQ5muViORyN0B5efSgo4YOeuLmf/cFHOyAm11e6pj2vHYPztFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RmVYrbrD; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7d09ab17244so394049185a.0;
        Sun, 22 Jun 2025 19:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750646893; x=1751251693; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CJHmf9BuChhjoB+0hgGrMkj7NgDeDPSjjYZiYpn+uMQ=;
        b=RmVYrbrDNQDa2+mqfXnk4jHRdfk2wShXCFFSXW0MaVfKVtCdlAy5vsYSzLnDEdDCkl
         M7LuSgVShlhrm5TzrrEynL5PBSx4K4V0PjSMAjGE+U6SiTrzLnCO+0LRPz/pGsPXDSLc
         WdbKy8y/huWvbzPHri2+AFmrSoQ3Ivwq0PikQMKO5WqCtfd0nMQBNxZjzAHRnJsaM01h
         8E47GuOeDIpGCFnfbgCh98HZeOiKd48naJoTrRCcwpF/at6hp24i+nQofYWLBkIpsJ83
         O+WSEizL9RSJPpj49CLiiX824t7gWfY2luQ2FNuSMmcQ7Z4AxWQRRz1fIdhik0veyXCs
         1WGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750646893; x=1751251693;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CJHmf9BuChhjoB+0hgGrMkj7NgDeDPSjjYZiYpn+uMQ=;
        b=t986vWnRA/8+n5L/mJRxyE4evoq0MIOpJA9gu/hlDSQAZM6hkPdRzm25Qg/49tv49R
         mtzSwbK4CVLJeW8zcOBiQFKXMaO1aYVdTe3fLj4P2f3EQGHM7MpdhFh+6BlrBp9TjG4h
         dVVLIrtKrqXI1wArahDd4RCjKOnU6o/ualCm6R/IoS2vu8+CDjxuB8lGwMXABpd9zgAS
         NBva+AO6Il8mEApkzH1VOsQ5uNHU+9xgfs148a4fidTv+2IkWvLjkQgtK6YnmKwEmKid
         IN6Yt2XzmZgMmsA2CeLS87R4z9l+0U75GOy0FjWhUaeNqrCUwg/YdOX6SQkxVIRNMzLs
         KXQA==
X-Forwarded-Encrypted: i=1; AJvYcCUrtmDq7FP3AM2OYTRjkdKJC+xqwcxDYDmn2+P66wXvBdRRTXo3MLE6/gMDj4GsXfAI8V4hLvWFUWTN@vger.kernel.org, AJvYcCW2hIW002sltrnDJwUQN6qiosstdjX7AFAcFWNVEfWdAFpj5qPSSic8IirXttY5OL4CdAoVG5SEDzzqk8eXGlU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiM/+X/PLjSbDX/mK4kNWlywDu9Ou3yEn53bsKE9PnB8yzTfvl
	Ey4GaKixDs2/gF6WVzYzW6/A+Vc20i7Tpdbo7C8zDEFVrj70P3ZYwociEksKwg==
X-Gm-Gg: ASbGncsotl8af6G6OKV3wXD0y1KarXcH3VKZMgPLBXVHg3Xe4H467Hm0aytjuFSFtf/
	hUtJ2G7WBPIFvFUk+GMaX1rtDgbm/VDHZ7yQAlygxzB30cq7wGwVKWQmyg3T5vKkKY7U0fZkw/0
	9XrhV9zgaSNQxfTgUXWKzD9byhOYNnCNQ3WPa3KjtwYN7Gbiq+s5zr+66YyQX3xaQh7N42kiCPJ
	AootMnDEvGHd2/RhXdQL5rfaPSqBr+9MvCpAAsW7gamHNtSMovQQ6BVYA9n3JqFsKLStP3tMZOV
	uQNCwmput1KNim6X1BpYOcAyw+zJFzM0oelzwpvFYkD49u+638Hy7uI8NPUpTx6N09KB7HPG5aN
	pLAQqrBQVLbloIUV8zHR15Cv60jS+MeNiDhnOU63OLOc7VCx78Omx
X-Google-Smtp-Source: AGHT+IEgIIA1mAlgzss/AbRlW6vBFk50Ygy+OJLrrlVrrDryQW9ibya3VqZUGjDidzFElD3ARz9mVg==
X-Received: by 2002:a05:620a:4727:b0:7d3:dccd:4048 with SMTP id af79cd13be357-7d3f99540aamr1889476685a.55.1750646892658;
        Sun, 22 Jun 2025 19:48:12 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a779d9db4bsm34012431cf.35.2025.06.22.19.48.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Jun 2025 19:48:12 -0700 (PDT)
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfauth.phl.internal (Postfix) with ESMTP id 634281200043;
	Sun, 22 Jun 2025 22:48:11 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Sun, 22 Jun 2025 22:48:11 -0400
X-ME-Sender: <xms:a8BYaBlh_9fB2I80ppJGMq8DKx65H_YaYgIQycySnRkvnCGkIbTb_A>
    <xme:a8BYaM3p-uHvF5RzYpOu0SopxYPyJVOmKFbJfzJu2ScgdpIeCop-DZIuQ878X6nPy
    VZfMNC1lnUAtfyK6A>
X-ME-Received: <xmr:a8BYaHoSQOyQEx6ic5HUKRr4J4xH5QMbFHtnNFUekCU26I7Sbmzg0UVnQw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgdduheekiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhnucfh
    vghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrthhtvg
    hrnhephedugfduffffteeutddvheeuveelvdfhleelieevtdeguefhgeeuveeiudffiedv
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqh
    hunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqddu
    jeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvg
    drnhgrmhgvpdhnsggprhgtphhtthhopedviedpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtohepghgrrhihsehgrghrhihguhhordhnvghtpdhrtghpthhtoheplhhinhhugidqkh
    gvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhushhtqdhf
    ohhrqdhlihhnuhigsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhkmh
    hmsehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtoheplhhinhhugidqrghrtghh
    sehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepohhjvggurgeskhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtoheprghlvgigrdhgrgihnhhorhesghhmrghilhdrtghomhdp
    rhgtphhtthhopegsjhhorhhnfegpghhhsehprhhothhonhhmrghilhdrtghomhdprhgtph
    htthhopehlohhsshhinheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:a8BYaBnmPEFJ4d8QKvi-WMEHfFqEuO2FHAvh3xzmaEkcsqYNlGqgEg>
    <xmx:a8BYaP0y-IaM7xqPn_0XfF4xLex-_D_ND-YIHOzDh9m2sQUf7MxvVg>
    <xmx:a8BYaAugn12AZrGcyaRiMgYkQFmjEVoNq_DSkx1kyCdo5ydSnsq4LA>
    <xmx:a8BYaDWYgs1GqJ0VGwXURuyTeV6QE5scxNx6bIbsr9OX2NJlqrJbpg>
    <xmx:a8BYaG055yTWM9iLKHGd0Vj6deBdyhKVufpRtwATfwBRZOaxwvojcxZf>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 22 Jun 2025 22:48:10 -0400 (EDT)
Date: Sun, 22 Jun 2025 19:48:10 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Gary Guo <gary@garyguo.net>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	lkmm@lists.linux.dev, linux-arch@vger.kernel.org,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>, Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Lyude Paul <lyude@redhat.com>, Ingo Molnar <mingo@kernel.org>,
	Mitchell Levy <levymitchell0@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v5 03/10] rust: sync: atomic: Add ordering annotation
 types
Message-ID: <aFjAarXzLPnv2kHO@Mac.home>
References: <20250618164934.19817-1-boqun.feng@gmail.com>
 <20250618164934.19817-4-boqun.feng@gmail.com>
 <20250621121842.0c3ca452.gary@garyguo.net>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250621121842.0c3ca452.gary@garyguo.net>

On Sat, Jun 21, 2025 at 12:18:42PM +0100, Gary Guo wrote:
[...]
> > +
> > +/// The annotation type for relaxed memory ordering.
> > +pub struct Relaxed;
> > +
> > +/// The annotation type for acquire memory ordering.
> > +pub struct Acquire;
> > +
> > +/// The annotation type for release memory ordering.
> > +pub struct Release;
> > +
> > +/// The annotation type for fully-order memory ordering.
> > +pub struct Full;
> > +
> > +/// Describes the exact memory ordering.
> > +pub enum OrderingType {
> > +    /// Relaxed ordering.
> > +    Relaxed,
> > +    /// Acquire ordering.
> > +    Acquire,
> > +    /// Release ordering.
> > +    Release,
> > +    /// Fully-ordered.
> > +    Full,
> > +}
> 
> Does this need to be public? I think this can cause a confusion on what
> this is in the rendered documentation.
> 

I would like to make it public so that users can define their own method
with ordering out of atomic mod (even out of kernel crate):

    pub fn my_ordering_func<Ordering: All>(..., o: Ordering) {
        match Ordering::TYPE {

	}
    }

I just realized to do so I need to make OrderingUnit pub too (with a
sealed supertrait of course).

> IIUC this is for internal atomic impl only
> and this is not useful otherwise. This can be moved into `internal` and
> then `pub(super) use internal::OrderingType` to stop exposing it.
> 
> (Or, just `#[doc(hidden)]` so it doesn't show in the docs).
> 

Seem reasonable.

> > +
> > +mod internal {
> > +    /// Unit types for ordering annotation.
> > +    ///
> > +    /// Sealed trait, can be only implemented inside atomic mod.
> > +    pub trait OrderingUnit {
> > +        /// Describes the exact memory ordering.
> > +        const TYPE: super::OrderingType;
> > +    }
> > +}
> > +
> > +impl internal::OrderingUnit for Relaxed {
> > +    const TYPE: OrderingType = OrderingType::Relaxed;
> > +}
[...]
> > +
> > +/// The trait bound for operations that only support acquire or relaxed ordering.
> > +pub trait AcquireOrRelaxed: All {
> > +    /// Describes whether an ordering is relaxed or not.
> > +    const IS_RELAXED: bool = false;
> 
> This should not be needed. I'd prefer to the use site to just match on
> `TYPE`.
> 

Right, I somehow missed how monomorphization works. I can drop this.
Thanks!

> > +}
> > +
[...]
> > +/// The trait bound for operations that only support relaxed ordering.
> > +pub trait RelaxedOnly: AcquireOrRelaxed + ReleaseOrRelaxed + All {}
> > +
> > +impl RelaxedOnly for Relaxed {}
> 
> Any reason that this is needed at all? Should just be a non-generic

Mostly for documentation purpose, i.e. users can figure out the ordering
from the trait bounds of the function. I will say we can probably drop
it when we find a Release-only or Acquire-only function, but even then
the current definition won't affect users, so I lean torwards keeping
it.

Regards,
Boqun

> function that takes a `Relaxed` directly?
> 

