Return-Path: <linux-arch+bounces-12662-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1382FB01D49
	for <lists+linux-arch@lfdr.de>; Fri, 11 Jul 2025 15:23:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9ACD57A8B70
	for <lists+linux-arch@lfdr.de>; Fri, 11 Jul 2025 13:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BBD92D0C6B;
	Fri, 11 Jul 2025 13:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cGubWbc6"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C538370810;
	Fri, 11 Jul 2025 13:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752240174; cv=none; b=IitN+ehx1VdiAv2G6aoIcVuDrVcKRg8zuOeJ2I5ZnrkVWkF9aAabkeU6RUofglDf/8ZKmsp7Vq+hCQkIoENk9e3midoZsRVInOovSYhaWSh8WrgBSHGD9/LattpbE7A2Evp1tR3iT+fioJO4j2KoYMFSf8z0EkeEmhKucC8XvO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752240174; c=relaxed/simple;
	bh=Z8xQn+iT3A5r4r5jVPej3tH0r1ytgXiZ3ITRDRty50c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YojsqugFBv5Qlb0lx75zaTcMwKfenmiiLmBga4SjDU4aSs/7OVauEla+8bgu+Pifh76NB2AutLndjsOCMl6mkgbrgX6lNlb2fVKMmZdtttKWhOVjvZyaMNSwrwUN7IMW6Q5e0Mv72ATDTIYZmgE0n2gDLgBmZVj9orD+q3QToN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cGubWbc6; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4a76ea97cefso21639361cf.2;
        Fri, 11 Jul 2025 06:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752240171; x=1752844971; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sYtOPsEZ+CQsVOIfnHqDEBe70N1WUVtu0akdEwqTHbE=;
        b=cGubWbc6CYl7O6Qeo3KH7lOWQHRqKX2+Aq8HT2m8nrugAdWdDKWhbVWLYvs77uiy5B
         bKG+Ab89I/nZcizvUnIU4BkTlDBquqb8/GSHx5rKenf8OSEuGdJgFXL78GK/T+FlHRF+
         F0kkzYK/4nOPsSClMu5adMI9MECDuXERqoU3HMOx40WwebAZQ26hdML80ZxNkgD5afCF
         ghyamKfVChZp/FwE434uyp77+gZE9Vn1zsjSxlP8TmxCcEWjvnMHWGrq/9QG2uiFSQmR
         bJgIbYCeSiDDaRnFD/9iSGdvrFVXEIXjKLZOK8KxlP1qEdCPLvPD6youNFjwN2Y075LX
         PBFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752240171; x=1752844971;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sYtOPsEZ+CQsVOIfnHqDEBe70N1WUVtu0akdEwqTHbE=;
        b=nMODfdKj1JRZybMYM06SeQpi+VOKx3RBixnzmc1xteyVumXqkHAz7lsNezc1ugmCwB
         Wv+kuSvTqnEsmrz2i1aoDsYJr7qnfh7v267AwuxKiON0Nv2ZvBgcYW12sdmF5iTzMjTf
         GfGo68wuL/9BChjuOcoHrk5EM6L6WFK8SUqi3nrUHMG7ouU2Gpoc+An81RjRUJZcYEbE
         vfJoB33qDhEjeBtN4/pEcPRml5/yDt4V5hqUX00Jv+NmRSdizPa5OU1O73L+HqJ9yhqk
         UF2VCVDRpQoMabSXYGif8sfnWxbdFIMNvmw9dTIR1wwuUg8plNF6HA8HR6P7zzbzym3a
         gj4Q==
X-Forwarded-Encrypted: i=1; AJvYcCUmJtbSSQYegij3bFAaNoGsgbaLJ41f4wesePZbPRpRIrG/urBHYf3e0u4A4WuAqXDK4f3TP375N7Ij@vger.kernel.org, AJvYcCV1/PcTeVTTqHg3f6kXXy35NcFi39hfQhNmY9FYowwuh0WuN80ZYrRsZ/074ySSw6wyRf0av52ZUMFtdKYIt+A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+kDFKftNy1HhPyPNrcyvZuZNCV9SM7YGbH9UZYiiCyBPw/sFS
	mvtxHqfp6cwDwYrLSRVU/RlfloNGf/22AYTBf2PBrsdCa0ZYMVmEsTgj
X-Gm-Gg: ASbGnctWcxiDPnhb69544G58kWH1e/5TFW8CRGE2vg0PtN4NMic3tdW39YmGHcLqvaG
	un5Fus1gReT1POgDBUjk2uWn/pjiUuKJnOsJ/F3/FaHN0JLFk1Giw2ccOVJ+jyZZtGvCfQQIZ6+
	ACzl779cc0CzOtc26EL8uIQ1v27Cbo/085kVMrNcXheICThp5EcmPhVZDOnxPFUMWHAW+FRvny1
	k6GXvaf9Rek+uJAE4vnpBPm1YXXMNND13wWHmsvldVSybw+n803tC04JbqBWP2trE0KVHFPUqTK
	A3PVnX7CxXqVy0Hg91e5sSx6UqTXsHW4hUAqcZYX8cRoQ94RySqBigjhFjZmapJrYL/2DBHCI4R
	Sqgt+GscrOjgjEGTr+qIcHk6lSWhN/5cTO03cmqSYrm1lhDz1FC8/MMZsoH3Q/MYpVcJAvXLtkY
	mnMOf2WP9/fSH8
X-Google-Smtp-Source: AGHT+IGmUHLQtt4/Ao6E8L4tLE0MefjpXF7XEULDetINGFZ/Jy/Bf0GiAFzHKLdLVH4nwoSXYOFI1w==
X-Received: by 2002:ac8:5d47:0:b0:4a7:6215:37f5 with SMTP id d75a77b69052e-4aa4158b43cmr37499891cf.48.1752240171472;
        Fri, 11 Jul 2025 06:22:51 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a9edea8e66sm21040151cf.54.2025.07.11.06.22.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jul 2025 06:22:50 -0700 (PDT)
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfauth.phl.internal (Postfix) with ESMTP id 2C2E8F40066;
	Fri, 11 Jul 2025 09:22:50 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Fri, 11 Jul 2025 09:22:50 -0400
X-ME-Sender: <xms:KhBxaMQbn9roFh1stN7y4wNzPoAgB95S-EdDhrqKjYKglgHvAlMd_Q>
    <xme:KhBxaLRTMuOkOdpunXWir1nZHZsn1A5_oOIr2DoFDAoMQsOP_j8PdIXrnzUFjiUyn
    12tmFklFsttZ8rdDw>
X-ME-Received: <xmr:KhBxaOa6oHlf5rEjRYt0nrvYKuR5mtCpa0sNhbfyyfzF8ZeJzY1GJzKZLg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdegfeegfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhnucfh
    vghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrthhtvg
    hrnhepjeeihfdtuedvgedvtddufffggeefhefgtdeivdevveelvefhkeehffdtkeeihedv
    necuffhomhgrihhnpehruhhsthdqlhgrnhhgrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhh
    phgvrhhsohhnrghlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunh
    drfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgvpdhnsggprhgtphht
    thhopedvjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheplhhoshhsihhnsehkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhk
    vghrnhgvlhdrohhrghdprhgtphhtthhopehruhhsthdqfhhorhdqlhhinhhugiesvhhgvg
    hrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlkhhmmheslhhishhtshdrlhhinhhu
    gidruggvvhdprhgtphhtthhopehlihhnuhigqdgrrhgthhesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopehojhgvuggrsehkvghrnhgvlhdrohhrghdprhgtphhtthho
    pegrlhgvgidrghgrhihnohhrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghgrrhihse
    hgrghrhihguhhordhnvghtpdhrtghpthhtohepsghjohhrnhefpghghhesphhrohhtohhn
    mhgrihhlrdgtohhm
X-ME-Proxy: <xmx:KhBxaPjhU5V0uxs42b41h0X8L75Gg_ZolvNTIBBShC26NW4v-xGHgg>
    <xmx:KhBxaDheUwpn0JHcg24jSRJwCN0JgA2-PGMr4y76DqB_FOe35e0w3Q>
    <xmx:KhBxaFKEaUG4yGuG6kPbY8dPU534TRt6meUhVxf7sNuvyERonwi_fA>
    <xmx:KhBxaKUMGA7aQBjZp8woKmSUqsC8ZKPDCJMqrVPZ_ebGh114O4pgLw>
    <xmx:KhBxaH2BY1eZZSH11TvWrxvNYITjGxmmvqOF7Lb2l40y42pf5aIJVXms>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Jul 2025 09:22:49 -0400 (EDT)
Date: Fri, 11 Jul 2025 06:22:48 -0700
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
	Thomas Gleixner <tglx@linutronix.de>,
	Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH v6 4/9] rust: sync: atomic: Add generic atomics
Message-ID: <aHEQKBT68xvqIIjW@Mac.home>
References: <20250710060052.11955-1-boqun.feng@gmail.com>
 <20250710060052.11955-5-boqun.feng@gmail.com>
 <DB92I10114UN.33MAFJVWIX4AB@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DB92I10114UN.33MAFJVWIX4AB@kernel.org>

On Fri, Jul 11, 2025 at 10:03:07AM +0200, Benno Lossin wrote:
[...]
> > +
> > +    /// Returns a pointer to the underlying atomic variable.
> > +    ///
> > +    /// Extra safety requirement on using the return pointer: the operations done via the pointer
> > +    /// cannot cause data races defined by [`LKMM`].
> 
> I don't think this is correct. I could create an atomic and then share
> it with the C side via this function, since I have exclusive access, the
> writes to this pointer don't need to be atomic.
> 

that's why it says "the operations done via the pointer cannot cause
data races .." instead of saying "it must be atomic".

> We also don't document additional postconditions like this... If you

Please see how Rust std document their `as_ptr()`:

	https://doc.rust-lang.org/std/sync/atomic/struct.AtomicI32.html#method.as_ptr

It mentions that "Doing non-atomic reads and writes on the resulting
integer can be a data race." (although the document is a bit out of
date, since non-atomic read and atomic read are no longer data race now,
see [1])

I think we can use the similar document structure here: providing more
safety requirement on the returning pointers, and...

> really would have to do it like this (which you shouldn't given the
> example above), you would have to make this function `unsafe`, otherwise
> there is no way to ensure that people adhere to it (since it isn't part
> of the safety docs).
> 

...since dereferencing pointers is always `unsafe`, users need to avoid
data races anyway, hence this is just additional information that helps
reasoning.

Regards,
Boqun

> > +    ///
> > +    /// [`LKMM`]: srctree/tools/memory-model
> > +    pub const fn as_ptr(&self) -> *mut T {
> > +        self.0.get()
> > +    }
[...]

