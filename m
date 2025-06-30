Return-Path: <linux-arch+bounces-12515-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 15946AEE24C
	for <lists+linux-arch@lfdr.de>; Mon, 30 Jun 2025 17:24:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 258CD3B2606
	for <lists+linux-arch@lfdr.de>; Mon, 30 Jun 2025 15:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE50E28DF40;
	Mon, 30 Jun 2025 15:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T8MbtFGP"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3255028CF44;
	Mon, 30 Jun 2025 15:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751297059; cv=none; b=KFOeX+P2YGRPVvlPLjF5C9v6URwG/t7ounrHCn/XfzH/hrXq0hjx1+rYlLzbuKdam7j1vQdXETTiX9h1Nkly7FwXmGnXB04Ak2ihF15pMf36tkN63z4qHQvX5pc6blUFLhY/o1anRnZD3RZZNROIWCWCBi6Sxozo7OqLxtr/pCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751297059; c=relaxed/simple;
	bh=M23ynhZy19mK9w79Y3elPi3q6QxYIYCws5YjIiWHC3I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YHn46Agp7GO3a+pFTOpby5pYpA+ifHvayBRC+xamfeaDcUHaZvBEHmrE/hX6e/RfNuYLOhR4q2erRVv9dgG7UGr7GAMaykO7PEtymV/EFtgnHEyZ+I3XYB0oT1MVGn8fUBcnycL3q4imlpdmtMCOIMAXydbh00+XM3ESLCQsiLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T8MbtFGP; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6fa980d05a8so48416966d6.2;
        Mon, 30 Jun 2025 08:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751297056; x=1751901856; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T/nxHBC5mvm0Wpw5nwM4/4J66VrNlz0x27CbN6M/i28=;
        b=T8MbtFGPtdzIdxEWRyTSUkZJf6cCujH2m6htaeHd9iLtfIAU6bwLO7iTaJlgNxs3gE
         kC6EJR9UWOahIRK/yljICYGFV7O8XeklwGquUKdlaSKN/lQDDFtU4OMdurojTn/4TJYf
         uryjyVIjy+4i3fH1cIPvWXXenrVUwtoNPvB+wdebezi02eSQ2l1Fgo/SnpbWtEU68dzB
         kF4QD9QtlUqxk48eGnhmeYa/1SM5eifeOldwTJlEAB9HXr8NV+woKa6PYH8zkEhUINne
         KtP74+aqVn2c3td9hhk7pab6HGZOqTEqoHnCpK6VBQL8iZ7EyJaHJnnWeoeGdXHTZPgA
         +j8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751297056; x=1751901856;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T/nxHBC5mvm0Wpw5nwM4/4J66VrNlz0x27CbN6M/i28=;
        b=k73ExvVU7JBK7XLHrivl01mMRReQRFpwjcfoMQC00bqDlwDgQdY0fqYAWgu6osLGKb
         K35ERI9+mkJZAgR/S3zGf8iTCDPIytWcdHsk1DDrhkGvuB2yHwDlJmxtU6vOOaC3rAM4
         TQ1CtdTmOVab7AMag8rehDrqwLXZTuaZ9wFYWRVSbL7UmGxEG1lfoB8WFmnedc2v0TfU
         0pN3ClgZ8JnuEZf+gXoW/RLkgaJpnyNilsBrXxn5VzLRw/TtLkvsI9lpQC/aERzGemEH
         w26YSxeM+f5Uh9HU9T0Pj8DOEpTpXMhKOaASSNP3JJaStz1/WEsHr91ruDHQaNnzFqFZ
         w/aw==
X-Forwarded-Encrypted: i=1; AJvYcCUMfGgJglA4DhhUkz+Aib31d0eXGvdkpFzMt31C+QzCUNiqXaHSkDrZa+pbjvggR6Su6Opo5ztvVDA4@vger.kernel.org, AJvYcCW7+rIZPs4oNi5k31MVwwM7PaWFXffaOVjQlKZAJ3nISN+V5N/CJANKTzYeT9IjeO8V2FLfCBCQCXOaIAjcWbs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9uEhJGyHNVWy6DUlj42kw2R/ZSYDwMiQReFxdIcJOdjs7/HtW
	5UCURsS6J1Gn8m/fMWcwuMrXTosKqR1Mgvgedg2m/1u7F638SXk1OhY9
X-Gm-Gg: ASbGncsTMsfcV4erQ473oKUaf1sOkBUd1Z497exm4bXYgGBWHuLcp2UqAmrsLc7iIxP
	231HofB5U8zMUHB1bJDq9D3oaS6F5oc6tHx42/xInziRhmrT7YQ26i00GnP8/cIxgT5pwbY3eOX
	JR1Phl39Lgf2vQhVEF6ejeIhIcLDszcMLk0rOEqFrlFWhANq7QTdIFyuD0TgADP+q/BFErFEsCn
	3Piel/2w8p0Y87hFB5WoTuOhyglWKj87IqhdhBLJVAIGPsK5E98CbsuRvKL2coRlxba0hEc0Qef
	u2EiVFGx+jTqAFYH6xGTH8qRBnIqYXX4e0cmpsqFUmiKyu4/trmKpvszlbi0pgD7iddr9/OCOwi
	PJUeXOFq/UZzgnjoSLeuvDB5TBVD3pYObzmlpu+TLFUk4O9I7IvtO
X-Google-Smtp-Source: AGHT+IHeVtCqSb2QoBZg08Zk3znfKSyCstCwyV8afrVw1t77VkguPSWePpJRLCLvm2eidPpMSXHg0A==
X-Received: by 2002:ad4:4ee4:0:b0:6fa:c5f0:bf57 with SMTP id 6a1803df08f44-70013a6d2c8mr216477886d6.38.1751297055817;
        Mon, 30 Jun 2025 08:24:15 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fd771ce44dsm69020716d6.45.2025.06.30.08.24.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 08:24:15 -0700 (PDT)
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id 8FBE1F4006C;
	Mon, 30 Jun 2025 11:24:14 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Mon, 30 Jun 2025 11:24:14 -0400
X-ME-Sender: <xms:HqxiaPWR8_7oGwl0msOihUymSO5YfJmT-BxMLH0J2qLMfbeppjmMhA>
    <xme:HqxiaHlfqa5ZJzOLJfBhkP8XDOzrkbFkVxd8mF7Nsy_dRmWI9Nx4MidL6bMtMKpIa
    7rf0Fmg2j26_KBImw>
X-ME-Received: <xmr:HqxiaLa00HKs3FQ4W-ca9XM09NHzEEZC0_hkTeqa8MeGmvgmh60X3j5nJBaeGw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduvddthecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhnucfh
    vghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrthhtvg
    hrnhephedugfduffffteeutddvheeuveelvdfhleelieevtdeguefhgeeuveeiudffiedv
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqh
    hunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqddu
    jeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvg
    drnhgrmhgvpdhnsggprhgtphhtthhopedviedpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtoheplhhoshhsihhnsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqd
    hkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehruhhsthdq
    fhhorhdqlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlkh
    hmmheslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthhopehlihhnuhigqdgrrhgt
    hhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehojhgvuggrsehkvghrnh
    gvlhdrohhrghdprhgtphhtthhopegrlhgvgidrghgrhihnohhrsehgmhgrihhlrdgtohhm
    pdhrtghpthhtohepghgrrhihsehgrghrhihguhhordhnvghtpdhrtghpthhtohepsghjoh
    hrnhefpghghhesphhrohhtohhnmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:HqxiaKXh4xW3_q-Zpc092U7HFs4OwiMG9rkAnBaq3Ez2sGIuB0wv0g>
    <xmx:HqxiaJkVIWWowdKC8XQnS9paOBoEJXcjVcefKDjiNByyBLw9FeiExA>
    <xmx:HqxiaHdEcOBKyhXtz27EyE8eSiPTkutqq5BvM8ZmvPJhYaQXGrhtmw>
    <xmx:HqxiaDGioS-hJKWyDd83VEf5vUSUkf-CdVn8dy3UH1a08k07rj1Prg>
    <xmx:HqxiaLnhZovproP3xm3gBsKslxi-kjqeImWfkaVvT3JY7Oy-JBwYxIBO>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 30 Jun 2025 11:24:14 -0400 (EDT)
Date: Mon, 30 Jun 2025 08:24:13 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Benno Lossin <lossin@kernel.org>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	lkmm@lists.linux.dev, linux-arch@vger.kernel.org,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
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
Subject: Re: [PATCH v5 05/10] rust: sync: atomic: Add atomic {cmp,}xchg
 operations
Message-ID: <aGKsHZ0saC-XkQlA@tardis-2.local>
References: <20250618164934.19817-1-boqun.feng@gmail.com>
 <20250618164934.19817-6-boqun.feng@gmail.com>
 <DAX6WZ87S99G.1CMIN6IQXJYPL@kernel.org>
 <aF6iXB6wiHcpAKIU@Mac.home>
 <DAXY0EJHHDWM.1KRSSJLOTCZ8F@kernel.org>
 <aF-aS5FLX7QIiiPa@Mac.home>
 <DAY0AZXDTCD3.OAWZ91IQJT2Q@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DAY0AZXDTCD3.OAWZ91IQJT2Q@kernel.org>

On Sat, Jun 28, 2025 at 10:00:34AM +0200, Benno Lossin wrote:
> On Sat Jun 28, 2025 at 9:31 AM CEST, Boqun Feng wrote:
> > On Sat, Jun 28, 2025 at 08:12:42AM +0200, Benno Lossin wrote:
> >> On Fri Jun 27, 2025 at 3:53 PM CEST, Boqun Feng wrote:
> >> > As for naming, the reason I choose xchg() and cmpxchg() is because they
> >> > are the name LKMM uses for a long time, to use another name, we have to
> >> > have a very good reason to do so and I don't see a good reason
> >> > that the other names are better, especially, in our memory model, we use
> >> > xchg() and cmpxchg() a lot, and they are different than Rust version
> >> > where you can specify orderings separately. Naming LKMM xchg()/cmpxchg()
> >> > would cause more confusion I believe.
> >> 
> >> I'm just not used to the name shortening from the kernel... I think it's
> >
> > I guess it's a bit curse of knowledge from my side...
> >
> >> fine to use them especially since the ordering parameters differ from
> >> std's atomics.
> >> 
> >> Can you add aliases for the Rust names?
> >> 
> >
> > I can, but I also want to see a real user request ;-) As a bi-model user
> > myself, I generally don't mind the name, as you can see C++ and Rust use
> > different names as well, what I usually do is just "tell me what's the
> > name of the function if I need to do this" ;-)
> 
> I think learning Rust in the kernel is different from learning a new
> language. Yes you're learning a specific dialect of Rust, but that's
> what every project does.
> 
> You also added aliases for the C versions, so let's also add the Rust
> ones :)
> 

Make senses, so added:

--- a/rust/kernel/sync/atomic/generic.rs
+++ b/rust/kernel/sync/atomic/generic.rs
@@ -310,7 +310,7 @@ impl<T: AllowAtomic> Atomic<T>
     /// assert_eq!(42, x.xchg(52, Acquire));
     /// assert_eq!(52, x.load(Relaxed));
     /// ```
-    #[doc(alias("atomic_xchg", "atomic64_xchg"))]
+    #[doc(alias("atomic_xchg", "atomic64_xchg", "swap"))]
     #[inline(always)]
     pub fn xchg<Ordering: Any>(&self, v: T, _: Ordering) -> T {
         let v = T::into_repr(v);
@@ -382,6 +382,7 @@ pub fn xchg<Ordering: Any>(&self, v: T, _: Ordering) -> T {
         "atomic64_cmpxchg",
         "atomic_try_cmpxchg",
         "atomic64_try_cmpxchg"
+        "compare_exchange"
     ))]
     #[inline(always)]
     pub fn cmpxchg<Ordering: Any>(&self, mut old: T, new: T, o: Ordering) -> Result<T, T> {

Seems good?

Regards,
Boqun

