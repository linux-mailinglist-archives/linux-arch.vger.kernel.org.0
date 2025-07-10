Return-Path: <linux-arch+bounces-12649-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F852B00D1F
	for <lists+linux-arch@lfdr.de>; Thu, 10 Jul 2025 22:31:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C53553A850A
	for <lists+linux-arch@lfdr.de>; Thu, 10 Jul 2025 20:30:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 913F72FE32A;
	Thu, 10 Jul 2025 20:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cIIbQi31"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C03EC2FE32E;
	Thu, 10 Jul 2025 20:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752179376; cv=none; b=oXDlOhS4p8STPrP9T45GkSKzJFa5Ror6+jjS8IXNj5VuAInzVfLuzPZwCMudKoy3rSW7vgzCMEPmrhJAT8W4IIc79C7IjcrU3KiOB93LkzdFDAwP+XU6d73gV/kwAxBdQLtrofy6XkgbjVjSOOdjmtwaKsWoLK1P2ktbl2tIk1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752179376; c=relaxed/simple;
	bh=hI6kF2VsYpQSxed7fWUz+U28xt0SkXt5Eiurxvo0eFo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gRJQLgwWeq3T56m7Y4mNNqj02csOdKAz8INHJSDMCikthcKOX5iXR/hLMBWYFvd3kP/HU43GiV8/VAVbSk2wYws6bQvfnh3Pbpi30k5x+QBbuoljOqAfzaX9xBTXSjiabrdmPEr93A/j6F80KIpBhXi5Vl3E1cfMA2QwHmdsK48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cIIbQi31; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7d9e2f85b77so223244985a.2;
        Thu, 10 Jul 2025 13:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752179373; x=1752784173; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n9Kows6//5K1XKbUlD36iwUd832otL138Wso87VJRuU=;
        b=cIIbQi31LZuVzcNQ0x/HdpbbyX4/Cn49YzqR4uKBrtyztqXNhVxS8rf8E15zKA8JJu
         Hk4heajay498ixqaET+pXmWDrgDf05oCk2PIL/dQ0DAcIlw7iGydohEPKi9bqZd8GR9j
         mJoPziPqqeletdVXKsCSO2iR5goE0Qvpe3XIUOFbbpPczrP0MlGstcn8p9+2QTEnilto
         q1Abg0HVIvwV0NHTTzcTAsjpV9Z4SLE4TgPcvQejUV2eWFT9JXh9YqFbRitNDwcqx5hZ
         Nts52sqrJNYcjueFQhKEX6D5JqGdpp0mXuE9hEvJ/R26aEiYOdydnIpj4/GZEaDvt8FB
         zMnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752179373; x=1752784173;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n9Kows6//5K1XKbUlD36iwUd832otL138Wso87VJRuU=;
        b=MMSC/V9TeZIBBdKMPILTslICQ/x5Xx4iLqDMIE8Fog8lXSoEEXUnN9uvxa0SegotQt
         2o55hyQnRpmtLLPeuCe8pOd8LjMcVkN9hBENq+Qjf7pqDl0q46QrDwTfFa44rY7d28F0
         mv3oa/7IiZqPJtFsV90yJfqhy1maT9VVJm8I9cb89+GK7JvLLy6CfnG2kL7ssgfuuT2u
         TscHYsPc71pYuoFBp1OCWV4xBOMxfzWjrcoEc4hw/C3s2dxWRCp82ZznEYpyuTDXTi2B
         8QqjhHopOVENO2oPssPWlBV7Ss7BZLo/sbrP92SGnZ6vPk5H+v8Yo81kaJDcgVLlAd30
         T/XQ==
X-Forwarded-Encrypted: i=1; AJvYcCVJ2iKJgJqF+L0LTEep8LeF2OImOA5v6NmTAq8QC5gSj3QxLEarZE/UiO2W0QcyGq+w8UAnWg38dLrd+jjlJ1U=@vger.kernel.org, AJvYcCVcyXRdIRdEL9KL6XMYpZmgkNUjtIhKxXrFRrjwAw0JZ5EIn1uY0hO9Jy2DqFfuDWpotuuc6w37gbzE@vger.kernel.org
X-Gm-Message-State: AOJu0YzXMSWSnfbiCIStVpHLdI0ARupLcLhOUiqDzltKK2yO0txc4kRz
	SV0PO5cFRFc0a+SQ0FIRUOfr9Foonz+hI2tRUm3p5kQgwo3ZSldjzaKv
X-Gm-Gg: ASbGncs1aa8RBaKUDtXaGPQlpQ6d64t22bpX7M6db5AH14GsVymXI/dNafN+hiF1q9w
	BkX8EXxMJS1LpfgjfD3jOdWBEw1NJ2Yz3UVz2zWQ0fWERisz1FLTStlVZ2ejvGemZpeE3Y1Ju8r
	V4864vgPDZzK3AzZTen5+1Msq7vdgLvbPwLMJEmq7ODwX/b9Ic7CHX1NgOpGxYUu0dPAroHytpT
	/f5TfDCmlY0D+tBmmVIO3fYVzvuUZuDr8xFyuiLq0F717jOW7awXtf5MT4OgHkd4jTJAzO9Fz44
	GBNyjIQXiyYKYn5tT+RRGLD2yvLSlE6mzxvMHyFZj2Ofu0CDegmglVJ8Rcfo4byMVLBtjTQDY0y
	susZeQhEtmDteaElM9r+dVZNty5XB5Fxhic61D8Ht2X+MNcGgptvt
X-Google-Smtp-Source: AGHT+IHTxHpV0SwGmDFllmbTBLgJt+IQPK8l4umZTYz9F0x4Va7+5/8tlYrHthE4s2dROSDM9gkudA==
X-Received: by 2002:a05:620a:a118:b0:7d4:57b7:bc12 with SMTP id af79cd13be357-7dde9d4b464mr115881485a.10.1752179373431;
        Thu, 10 Jul 2025 13:29:33 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7dcdebeadb5sm136572885a.113.2025.07.10.13.29.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 13:29:33 -0700 (PDT)
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfauth.phl.internal (Postfix) with ESMTP id 26EFEF40066;
	Thu, 10 Jul 2025 16:29:32 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Thu, 10 Jul 2025 16:29:32 -0400
X-ME-Sender: <xms:rCJwaApMAG3WehairgMCq8kOSYcKvMddKt9s7szDEwvLTogrYO4TDw>
    <xme:rCJwaILFerzZGDlmOTkw4csLP2SdPJPzHC7jmO8TG3CRlnOR_6U2lkLa-nijzVRJw
    chnhFI0VM5NPb_5Iw>
X-ME-Received: <xmr:rCJwaJxDoKHRCxVqWXHTBIs6llhd7KG1GACW0EPSONc5jKvUnmOxWxwhYF3anoVz6UbHpEMUvdey0hWHD_L5ezcPi24>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdegudegtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhnucfh
    vghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrthhtvg
    hrnhephedugfduffffteeutddvheeuveelvdfhleelieevtdeguefhgeeuveeiudffiedv
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqh
    hunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqddu
    jeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvg
    drnhgrmhgvpdhnsggprhgtphhtthhopedvjedpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtoheplhhoshhsihhnsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqd
    hkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehruhhsthdq
    fhhorhdqlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlkh
    hmmheslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthhopehlihhnuhigqdgrrhgt
    hhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehojhgvuggrsehkvghrnh
    gvlhdrohhrghdprhgtphhtthhopegrlhgvgidrghgrhihnohhrsehgmhgrihhlrdgtohhm
    pdhrtghpthhtohepghgrrhihsehgrghrhihguhhordhnvghtpdhrtghpthhtohepsghjoh
    hrnhefpghghhesphhrohhtohhnmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:rCJwaHabvA280zNgmWRCUYxiiRtxOB7BFdP3fzB8P0egKRMvSLaxTg>
    <xmx:rCJwaN6MuakdEsUfkF6v6aCHEK7TRJKsVZ8ewUsMpmy_EqhSIzDx2A>
    <xmx:rCJwaACF3OI3zx8uVHhJ-JWze1x5lpppwZs0aLk65pMEvBhDhBSWBw>
    <xmx:rCJwaLuqE6Nqlit1Cv77HRIYlf2VTRDVoSiSvt_B6klWLtN4nPPuyA>
    <xmx:rCJwaNuU1aYnFxMo6iLrDLg7_BdA_kdupz1-vus4I2wi46AAq4QRP1cu>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 10 Jul 2025 16:29:31 -0400 (EDT)
Date: Thu, 10 Jul 2025 13:29:30 -0700
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
Subject: Re: [PATCH v6 2/9] rust: sync: Add basic atomic operation mapping
 framework
Message-ID: <aHAiqhPe5OwVioUe@tardis-2.local>
References: <20250710060052.11955-1-boqun.feng@gmail.com>
 <20250710060052.11955-3-boqun.feng@gmail.com>
 <DB8BQGJNFDAY.BGQ8CZSFFOLH@kernel.org>
 <aG_Yah5FFHcA3IZy@Mac.home>
 <DB8HQLY48DFX.3PBBUTQLV14PC@kernel.org>
 <aG_nT3H8J-h2qwr5@Mac.home>
 <DB8MAQC4V57F.1GGYO1PNPOV2X@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DB8MAQC4V57F.1GGYO1PNPOV2X@kernel.org>

On Thu, Jul 10, 2025 at 09:21:17PM +0200, Benno Lossin wrote:
> On Thu Jul 10, 2025 at 6:16 PM CEST, Boqun Feng wrote:
> > At least the rustdoc has safety section for each function. ;-)
> 
> I don't usually use rustdoc to read function safety sections. Instead I
> jump to their definition and read the code.
> 

Understood. It's probalby the first time we use macros to generate a few
unsafe functions, so this is something new.

But let me ask you a question, as a programmer yourself, when you run
into a code base, and see something repeat in a similar pattern for 10+
times, what's your instinct? You would try to combine the them together,
right? That's why duplication seems not compelling to me. But surely, we
don't need to draw conclusion right now, however that's my opinion.
 
Regards,
Boqun

> ---
> Cheers,
> Benno

