Return-Path: <linux-arch+bounces-12644-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C9DFB00BD5
	for <lists+linux-arch@lfdr.de>; Thu, 10 Jul 2025 21:06:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 660791C88711
	for <lists+linux-arch@lfdr.de>; Thu, 10 Jul 2025 19:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C9242FCFE0;
	Thu, 10 Jul 2025 19:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SknbUc2L"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D95125760;
	Thu, 10 Jul 2025 19:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752174409; cv=none; b=AtkSo39rj6rW2TXtJXl0wdwpVFZ9wpJjci8QupvcnWakCe+vUEk6cdp2Gp70URDi56lygERtqVElbNDcY5A5pU5iyTIHx4/72CMs+AUS1FPob9dqnf9DFPDGQEVbd8ijcWN645FtIJcxSk1FyOYllBofJl7Blpb9REQR1RNbVDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752174409; c=relaxed/simple;
	bh=d1TgekxlM1F6cmtjM39Ek7NrGs4UiAhKYGCORsJeMDg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DQjT8WjznQvMrTr+W9nC0+6N5U+JPcmJPiBO04hCw0zXV9Wi1iKIbwda8VkcqXMKXzHAIVwrHr0caU7y9fVQd9OJFfsCZvK4JjMhrU9iLJZJheP7ud/QXqahgubCKdAdkI7ljfuLy0WL/aiO1fgEiUB+UNa3trWoligC4969eQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SknbUc2L; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-234d3103237so2708645ad.0;
        Thu, 10 Jul 2025 12:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752174407; x=1752779207; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d1TgekxlM1F6cmtjM39Ek7NrGs4UiAhKYGCORsJeMDg=;
        b=SknbUc2L480v4Hh0Fpwx+xkwcd7m5dqZWrGwWgknXc5VcNeCGnXxryAfWPOYdZiSS0
         PMv4johbNmqUJURFt5uLzPTn9Ac/6UXEe15p1ejo2GeCve2ZUJnmx2pN28VxU6uw+zVU
         qldHhuFCyYBiUJ1SdQZNBz6B3MC2NXtfxze+yuaVdS3H9FJHwC+g7PTL3Vg2Yxiht61w
         nV4dF5pIjCsdoZxx2o/S39Ewx43ahe+Dx8ohA8N3IVQsyxAxCYeBctWp8lnFR6360nwn
         Pjk3XcEiZqBft/M9o0fglra6kqg2SxNIH0Jd5ox6D16Bu7fCH/aBpzrvxjl/UNBJsmq+
         uGpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752174407; x=1752779207;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d1TgekxlM1F6cmtjM39Ek7NrGs4UiAhKYGCORsJeMDg=;
        b=gy6fH9QkJhJ6E/OqGD0f1zlPOpJ2ANNur3UQp5pQKqU8T8EAbwOr5SMYEwVHfh/Fmf
         vuExdm1wF7LQ5lrqSCZSQg9hRGbD26KZfxGtjnke3tmiU/p7cgxTAg9J7f1GVPrRLai9
         dqF9bwdYjkUzhr0q4ApAZ6hkHybkT+oBBumTgLBQNBRwOuhcwv3Jh7giia+/tsP5Wxuk
         mDQdDqhWdseKuvIlql7OtU4eVVwPmxYgaaThM9fzMSopNOXBnH0SbmgLtQg9pet3TSeH
         Te6YWhTxalBgnVpNWa9PlvVKQXZWitvjRju9GwKVYkjowZtIqZKhmE7fkYGh6bNJ6F41
         d8oA==
X-Forwarded-Encrypted: i=1; AJvYcCU2p6vKI7UFo9q/xxMRxftievuV4LVTMBx8tDq8TtNWKXTrQt7/tHKrBRMdQsaGj2sT22vT1cLGrOayFMhd@vger.kernel.org, AJvYcCUHBvZi1CVbiMzT8F/zVY8tUAjW0SFNXu1fUEMD5v2cd5V6uGtJoCf0h4gn0oqdE9JKxeG/8QSOShin2Lhzf/g=@vger.kernel.org, AJvYcCXLCaYc9iMYAVC2eY7vo0bUsL3txNiCSOqCeez7MIhkQxmWYh1aOEbwTFx/FLU4Uqlq+R4724Luq+SQ@vger.kernel.org
X-Gm-Message-State: AOJu0YzQoGROlpYZXMnvbBk3ob5PissnJf6dd8fBjSti8GWgW8GZ2vNe
	OsCsDxjc2jMNup99mgVIzXs+3kBjdrsyJOtsaOjP9MzDQLo1Z2iEngJWg64DRZAMbVTKnOK+6QO
	h1sqlXlStHobieIvA+pmcOPs4ekIk6bk=
X-Gm-Gg: ASbGncsBi47AR0iI6JLGwycI+h6QjEkKg7mlTV2HDhQkKVTydS38ZGFH5J18Ku8LL51
	YUBdZHhUaGx8EL71N18EmfWUEFifEaX5MsAZs+VgFkd4pQ1avqXVGkYqxU4qcGTptSR9bCzxiGW
	qK5pjrIYqUFMf0aRHbfFTaAegV5EWYM4AKkK/R5F4i
X-Google-Smtp-Source: AGHT+IHkEFYCa3ATI/QIEvvVfoRX0qcKn6U4rLVncaPPUJONzR3iCGpU45qxH8NuVBQIRr9ulvGNtoRqwfRpZl1JiFI=
X-Received: by 2002:a17:903:1245:b0:236:71f1:d347 with SMTP id
 d9443c01a7336-23dede76501mr2207985ad.10.1752174407365; Thu, 10 Jul 2025
 12:06:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250710060052.11955-1-boqun.feng@gmail.com> <20250710060052.11955-4-boqun.feng@gmail.com>
 <4Ql5DIvfmXBHoUA428q2PelaaLNBI5Mi0jE3y3YPObJLRgY73zNZzQ8Pdl2qq25VWsMQFKUpYRHHQ1e7wFaGUw==@protonmail.internalid>
 <DB8BTA477Z2V.1J7XFLDXHMN2S@kernel.org> <87v7o0i7b8.fsf@kernel.org>
 <aG_RcB0tcdnkE_v4@Mac.home> <DB8GUTJA9QU1.X112WTV7ABZN@kernel.org> <CANiq72=Oq-JHkBuTAZPVYO5omuXswgGfLXu+nAGwEdRdgkU-0w@mail.gmail.com>
In-Reply-To: <CANiq72=Oq-JHkBuTAZPVYO5omuXswgGfLXu+nAGwEdRdgkU-0w@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 10 Jul 2025 21:06:35 +0200
X-Gm-Features: Ac12FXw1CiwqDgqRLKnAYlHxWPBCV-YdBB3D1UT2TjwRBmWnZYqiMVSnF3Wqfxk
Message-ID: <CANiq72=K8+Rx_3yDXPxsTMftg6Kabg=_O3voMKNoQ647wznGpw@mail.gmail.com>
Subject: Re: [PATCH v6 3/9] rust: sync: atomic: Add ordering annotation types
To: Benno Lossin <lossin@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	lkmm@lists.linux.dev, linux-arch@vger.kernel.org, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Mark Rutland <mark.rutland@arm.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Lyude Paul <lyude@redhat.com>, 
	Ingo Molnar <mingo@kernel.org>, Mitchell Levy <levymitchell0@gmail.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Alan Stern <stern@rowland.harvard.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 10, 2025 at 8:32=E2=80=AFPM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> I guess there could be a lint that detects a given item being `use`d
> which we could use in some cases like this.

Filled: https://github.com/rust-lang/rust-clippy/issues/15244.

Cheers,
Miguel

