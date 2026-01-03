Return-Path: <linux-arch+bounces-15648-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A8047CF0695
	for <lists+linux-arch@lfdr.de>; Sat, 03 Jan 2026 22:53:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2593D3014619
	for <lists+linux-arch@lfdr.de>; Sat,  3 Jan 2026 21:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E6D91FC101;
	Sat,  3 Jan 2026 21:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B7MeLHpN"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D43A145A1F
	for <linux-arch@vger.kernel.org>; Sat,  3 Jan 2026 21:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767477208; cv=none; b=X5fubEC2oJlgH2WhkgYiLDRVv3MH2Ln48w8hLSzfJWISBsc8I1dx8EQNCcVCa5/HsnHc4qexDqOHyDYzpFL5lTqa/O8Grge/YSwprkd6eOxlPaL+/JAZj6appO1gyk3KDPTy2MsRWbx59bGC5JC0f3FRbstzdfXYFkZHjypB6qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767477208; c=relaxed/simple;
	bh=+a0rZ61BlR4asBFS2IQXtu1dxzG09+n5xc1pwtVYw6g=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=HMCwDJ9AhDKBv0FOpu+BSnxRoL4LqVu92RwBEXSMFnr/BuHNakD7vexRKUptSehNIKDOZg9qvZOvi8FiMNs878O53K6pipDZ9RzRRu4RdqBWUUZqrEaqqWUUKPpg99yMTk/wubBbu0leuqJWMBNuFN4F5bio0jaDccOfN14+DDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B7MeLHpN; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-34c21417781so13674503a91.3
        for <linux-arch@vger.kernel.org>; Sat, 03 Jan 2026 13:53:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767477207; x=1768082007; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YVEPKpy/6ii8Fxn8hb/Lg9OkHV0SZSbCKptj+BZGST0=;
        b=B7MeLHpNMok4+Dl1/iwvHRxFsvgpe5kTTl99sjk4z4Aha8jMm5TnlIxpEiqtaurq1L
         e5NzyY1AuN8+56ACDCudlfkMwFkdO3qj1+MtJfI0V3aCaBUyPbgE5baY5Qxh40a1Dxrm
         IO6LxeB65YAI1/PDm+DpSCs6nNU30BgKlVyH5Qt33lszw0oBfn2QmC/zmwFwNvEbXZkJ
         0qQ9yVYQi2s0t9LNmhEQswFi8esQ8c4XGmwBDaRF963X7FCPr/25WC54FWlIpy95B0IY
         DGqmWbKwZ73JQ4LaVyYdpsBaQKOioCPW/PBxtkfW8ZW+M1k5PAoQkp4BtAiilW4Cj+VY
         3DmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767477207; x=1768082007;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YVEPKpy/6ii8Fxn8hb/Lg9OkHV0SZSbCKptj+BZGST0=;
        b=TCtkrhtZ4TK3+W4rRWgCwYr8vRX1YUgTDla65hHWWo5EBBk3zikjOTK4r0c5yHTZ//
         zoJRev9eDywRu5Y4UhC2VT4rzgeHYTcjS6+6rv8j9k/QSaje+txaiHN1K/b6VV5wYmHx
         HusKkBe4VQX3Hl2hwW4GrZWJX37rgbBbKo3wlsy8ILijY0Dv3b3s8Qxx/duHvF9KqQQi
         Efide5iGVkOJdOjtO+iSTA7UA9kxXUdc1qpi5NluSUEupd/STHEPlBYenJzDbbVTYErR
         JzyNH6PxsvwWgPPMAuct23CQnOW+Gj1X+7jFVt6L3VcMmmflcCGTJrzHasnvtzvvySIl
         ESvQ==
X-Forwarded-Encrypted: i=1; AJvYcCVuDSVPmr75obQ+A1YqyeUgIg4IPiCBK17bfaMWO+zGKzay5D/18vwFO5143sD2OCOOWGf0G357KXY8@vger.kernel.org
X-Gm-Message-State: AOJu0YzqN8KpI68NCtwIwgP1OmiO/kTNbQ+rTMEue5zfhmwnaSTVqBqm
	TBKuYwuPnscdsw92rdSopsje9BhfiHGHshsyNukBChmJNqgr6RPV8C+q
X-Gm-Gg: AY/fxX6I4cKlkbzTE/hrb2doCod932MzNmNm+k14UWg44TixxOsdywwDNV75n4FxHoH
	tmgF29GiMYlfy2h6dxSOQaghm8/0yw5yuOypHNu4XCJ/KNxA8YriKcdhTeGD9j0v3lcpViEoJfK
	1Tev+jTqw6lYVa0FAeHvDI2KKnvpnI0fMc5zbqmOCrQMXYr4G9GIVDtgbTXMDmQ8iVSMSeGjx51
	IGOu7EiS+x2QV+FCuU1YBzEr8p/mUWLNo9gXdGgtQ0R1NbWdh4GCog+QjtNs705i/ojzEojpTb6
	QSSMa9m23IT0g2tZS3Yxlad4i5VHqQABwLMfbJgljRVhceLtHD8Gk3Ns8ziVvTHVYwuLvqcYWuy
	Vq2/+lMA1vOY8cwpTpMheyay9P6AgaibhCzDsboDPqLGjcPgVNmSvQOmTBTt45TKBCXJYzs5Rj3
	f7LwwmMAuRe8X6W6oV+t+1KX4yJE2N4s/A3tUaKg5vym7F9g4yJ9g5vfNGYBujtTuhd7heZX8PW
	4WqwA==
X-Google-Smtp-Source: AGHT+IGL/W8SoSD2fmGfa2gB+6LIj02HrBGjLwShgzdq0BkitG600i+3wzdiUmWQGf2CnNieEduBeA==
X-Received: by 2002:a17:90b:2585:b0:340:bb51:17eb with SMTP id 98e67ed59e1d1-34e92131db5mr39951859a91.15.1767477206570;
        Sat, 03 Jan 2026 13:53:26 -0800 (PST)
Received: from localhost (p5342157-ipxg23901hodogaya.kanagawa.ocn.ne.jp. [180.39.242.157])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34f4751d783sm2468879a91.0.2026.01.03.13.53.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Jan 2026 13:53:26 -0800 (PST)
Date: Sun, 04 Jan 2026 06:53:11 +0900 (JST)
Message-Id: <20260104.065311.609258219418619592.fujita.tomonori@gmail.com>
To: gary@garyguo.net, boqun.feng@gmail.com
Cc: fujita.tomonori@gmail.com, ojeda@kernel.org, a.hindborg@kernel.org,
 aliceryhl@google.com, bjorn3_gh@protonmail.com, dakr@kernel.org,
 lossin@kernel.org, tmgross@umich.edu, acourbot@nvidia.com,
 rust-for-linux@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH v1] rust: sync: atomic: Add i32-backed Flag for atomic
 booleans
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <20260103190511.2d267164.gary@garyguo.net>
References: <20260101210430.6b210dc6.gary@garyguo.net>
	<20260103.194448.560764475765900721.fujita.tomonori@gmail.com>
	<20260103190511.2d267164.gary@garyguo.net>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Sat, 3 Jan 2026 19:05:10 +0000
Gary Guo <gary@garyguo.net> wrote:

> On Sat, 03 Jan 2026 19:44:48 +0900 (JST)
> FUJITA Tomonori <fujita.tomonori@gmail.com> wrote:
> 
>> On Thu, 1 Jan 2026 21:04:30 +0000
>> Gary Guo <gary@garyguo.net> wrote:
>> 
>> > On Thu,  1 Jan 2026 19:27:18 +0900
>> > FUJITA Tomonori <fujita.tomonori@gmail.com> wrote:
>> >   
>> >> Add a new Flag enum (Clear/Set) with #[repr(i32)] and implement
>> >> AtomicType for it, so users can use Atomic<Flag> for boolean flags.
>> >> 
>> >> Document when Atomic<Flag> is generally preferable to Atomic<bool>: in
>> >> particular, when RMW operations such as xchg()/cmpxchg() may be used
>> >> and minimizing memory usage is not the top priority. On some
>> >> architectures without byte-sized RMW instructions, Atomic<bool> can be
>> >> slower for RMW operations.
>> >> 
>> >> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
>> >> ---
>> >>  rust/kernel/sync/atomic.rs | 35 +++++++++++++++++++++++++++++++++++
>> >>  1 file changed, 35 insertions(+)
>> >> 
>> >> diff --git a/rust/kernel/sync/atomic.rs b/rust/kernel/sync/atomic.rs
>> >> index 4aebeacb961a..d98ab51ae4fc 100644
>> >> --- a/rust/kernel/sync/atomic.rs
>> >> +++ b/rust/kernel/sync/atomic.rs
>> >> @@ -560,3 +560,38 @@ pub fn fetch_add<Rhs, Ordering: ordering::Ordering>(&self, v: Rhs, _: Ordering)
>> >>          unsafe { from_repr(ret) }
>> >>      }
>> >>  }
>> >> +
>> >> +/// An atomic flag type backed by `i32`.  
>> > 
>> > I would recommend that we document that the backing type is the
>> > (perf-)optimal type on the target architecure, so arch can decide to use
>> > i8 as backing type if they prefer.  
>> 
>> I'm not sure I fully understand the intent yet.
>> 
>> Do you mean we should document Flag as being backed by the
>> (perf-)optimal integer type for the target architecture, so that the
>> backing type can remain an implementation detail and potentially be
>> selected per-arch (e.g. i8 on x86) via cfg?
> 
> Yes, I don't want anyone to rely on it being i32 (at least for now, before
> a concrete use case of doing so appears).

I see, the following comment works for you?

I thought Boqun had Revocable in mind as the intended use case.

/// An atomic flag type.
///
/// This type is a performance-oriented boolean for atomic operations.
/// The integer type used as the backing representation is an implementation detail, selected to
/// be (perf-)optimal for the target architecture.
///
/// Currently, [`Flag`] uses an `i32` representation. This is because, on some architectures that
/// do not support byte-sized atomic read-modify-write operations, RMW operations (e.g.
/// `xchg()`/`cmpxchg()`) on `Atomic<bool>` can be slower than those on `Atomic<Flag>`.
///
/// If you only use `load()`/`store()`, either `Atomic<bool>` or `Atomic<Flag>` is fine.

>> Yeah, that sounds like a good addition.
>> 
>> +
>> +impl From<Flag> for bool {
>> +    fn from(f: Flag) -> Self {
>> +        f == Flag::Set
>> +    }
>> +}
> 
> A `#[inline]` is warranted here. Also, it'll be good to have the
> conversion for the other direction too.

Of course.

+
+impl From<Flag> for bool {
+    #[inline(always)]
+    fn from(f: Flag) -> Self {
+        f == Flag::Set
+    }
+}
+
+impl From<bool> for Flag {
+    #[inline(always)]
+    fn from(b: bool) -> Self {
+        if b {
+            Flag::Set
+        } else {
+            Flag::Clear
+        }
+    }
+}


