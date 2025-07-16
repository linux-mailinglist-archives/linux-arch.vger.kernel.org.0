Return-Path: <linux-arch+bounces-12812-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10BA3B07680
	for <lists+linux-arch@lfdr.de>; Wed, 16 Jul 2025 15:00:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC3AB7BED3E
	for <lists+linux-arch@lfdr.de>; Wed, 16 Jul 2025 12:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EF1A2F5489;
	Wed, 16 Jul 2025 12:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JlwGJ25z"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA8B72F5470;
	Wed, 16 Jul 2025 12:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752670648; cv=none; b=PHn80fS4g9cRRZYzDF7c+QBL8FqbUx1ZTydP+Yoi42v9RkmrMox8X3YX1LhQntyFaglQLJH2wXSyrSLxfgEVpOx3l6cNSEKS+7UZER1LEsirAHKTgGyaNBOooPMGeqemWMi2oyMFKakeYuQO/MmtW6NKrkew6XwMWBoYKztpNe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752670648; c=relaxed/simple;
	bh=m2LnwIGYhLWQq9/vNrmq/h8g1o9AkmJ0CbCqU4PYnxM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e/aJhiU699Hp+TLVlXIk0M+bwISEljgxPFqJ321SVEZMm2CKp+nlFTJcMpor4w3zHwfPV59g7gb+vdzlXf180vmpKiX6YFEYhnGFx2UVGI6G3BpEC+m01CoMMFGEgwp0qMXxvnDfkVLg6m5IRzJ6Zl6IwBQ411fQCRyKQt1EExE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JlwGJ25z; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-558f7fc9d7fso235633e87.1;
        Wed, 16 Jul 2025 05:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752670645; x=1753275445; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GnUmwmHd04RAbDihiDJsc+TMOL+rIoUaNraa5eqvF7w=;
        b=JlwGJ25zhCRoKi+uiDEy1An4MiM98mEZwqQ4l9JMJ/LXfI06ryqCFLf94FPh0HwgHr
         9ws/OlMURnBWwgndU5tKiMZo5/8coaf1LLeoSjMW1fsslJOJArq0LfWaBNeDOOnj5INh
         QBRPfNIO3EtZ7a04OqqlHkJt7rlYOywxVVIrwqR5dfRDwSllSzYKqGBtSkvtFYQEGyUd
         3OFsQP5SGVtUuiRjj/j0pnS8rvKffibmmScq7BH573pqnZlbWWo3xpnYBOjSfBiQcMmD
         PjZKSoFydFwkUaivFJOusE+RpxOcXVw5hPdX+XwIH+NEPdr7asnkU1AYFaWQEPhyrgJo
         Vs1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752670645; x=1753275445;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GnUmwmHd04RAbDihiDJsc+TMOL+rIoUaNraa5eqvF7w=;
        b=atltmgPapKNuecaJeVBgYwx6E5SCGVfpnU9OHynxZlI7lyXR4Zb+zV3xwmiOZSAfKz
         usSeeDziwNtNjzGHCTt07kuFqgbrpoap/LTCFD94gnViUk2gPNKqhKdcY2WAyjknZnSr
         McnVovP9Lf+ElEUef23PGtBfUd6fIoGD8Tc0thfobqIdgi3oQNT2/S8TJiyAwKzrmoxu
         KqtMIruu8ma+a6Tygnrs/wiIV10SOOD5QVX4REC/gpRno0os+5zz0/35WtYthQWfjOlq
         fcShTzjzuis57wTgAmUOdEFZlLZkG2nN2Iruy5GF6f4yOcCmhr8EUI8GgbTtDn0o/teI
         X0/A==
X-Forwarded-Encrypted: i=1; AJvYcCUC4EMoIjFeido3KthFLlyubcyVaCxzhXC9B/p4P8G9i5V07GMyQA06RbHAQfD3UNORwy2yU2EMnsF1aV4H9LM=@vger.kernel.org, AJvYcCXp0wUS5X1KFlykACYoJYi4LGESH/2Qv/nuAqWW56WZfrD5GaWc6243/WjDYNfbBg8bxNdZuIWjAg8/@vger.kernel.org, AJvYcCXt+ny8nYXEZa4AUB16ds27pKeLqCBcPVT2civtU2csFwtOvX6f/LYZwPg7v4s3A940O5TJWguwP64pNrsr@vger.kernel.org
X-Gm-Message-State: AOJu0YyiOs91nDxV/GzR5HFfsOckiJsf/CvZDFSPwL6NCwLNy4xpaglx
	JXIqMWt4SbfGzE8YikEECLAhYE6599V5Knld9FhFFY+Ua+0khO8MyFSHlVXe8QD5NdgYEiKVr26
	+JVG5jkTjZRMWv43B+wU9Z4tP3wV6i18=
X-Gm-Gg: ASbGncvrTxqObRCYAeLBfiZ44M74FqKTEb6UGMKNJgvj6Bl0/xlzOHyaZiJmCx+TCcd
	yiqJrqcT30yReR04E1YyPPvZwVaS3F3bZAYkjyqMOcHPRz/wPmNF7ntwjVHTZBjwegzLGCKaWgL
	xO34R5jEbrlWT18NIBzZImchttvK1EJ5GRTrxGbCWMOyztdKSMUAcHa6cVGPdolmfu4WxtoZmTI
	WJ4/Q==
X-Google-Smtp-Source: AGHT+IHg75d3gVVHrcM/53JCe0JWtEDOc+JkT8umOlD84lSgO0oBWv54W8RcNo6KapvHj4vSpgUVoGscVjFYDN0Vl4M=
X-Received: by 2002:a05:6512:1313:b0:554:f76a:bab8 with SMTP id
 2adb3069b0e04-55a233d6c0dmr354370e87.15.1752670644558; Wed, 16 Jul 2025
 05:57:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250714053656.66712-1-boqun.feng@gmail.com> <20250714053656.66712-2-boqun.feng@gmail.com>
 <2025071611-factsheet-sitter-93b6@gregkh> <20250716124713.GW905792@noisy.programming.kicks-ass.net>
 <2025071651-daylong-brunette-ed9e@gregkh>
In-Reply-To: <2025071651-daylong-brunette-ed9e@gregkh>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 16 Jul 2025 14:57:09 +0200
X-Gm-Features: Ac12FXw_Z0jSZPqLajQHzSS9go_boufb3ia_2RqCm041xzqV0b0NUKvb3yFhI9g
Message-ID: <CANiq72kn1MQqY8MXaR9bnSYD=Wo7yC4Wxcq0p0Z4w2K=_dDpiw@mail.gmail.com>
Subject: Re: [PATCH v7 1/9] rust: Introduce atomic API helpers
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Boqun Feng <boqun.feng@gmail.com>, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	lkmm@lists.linux.dev, linux-arch@vger.kernel.org, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Lyude Paul <lyude@redhat.com>, Ingo Molnar <mingo@kernel.org>, 
	Mitchell Levy <levymitchell0@gmail.com>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Alan Stern <stern@rowland.harvard.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 16, 2025 at 2:54=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> Ah, ok, that makes sense in a sad way.  As long as someone knows to
> regenerate these files when needed, hopefully when the C files change
> someone knows to update these rust ones...

IIUC, the line added in `scripts/atomic/gen-atomics.sh` will make sure
it happens at the same time, right?

Cheers,
Miguel

