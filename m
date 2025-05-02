Return-Path: <linux-arch+bounces-11805-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AF0BAA77E1
	for <lists+linux-arch@lfdr.de>; Fri,  2 May 2025 18:56:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B96D33AD203
	for <lists+linux-arch@lfdr.de>; Fri,  2 May 2025 16:55:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 221A625CC79;
	Fri,  2 May 2025 16:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WyBa23Gc"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4438C2609D0;
	Fri,  2 May 2025 16:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746204946; cv=none; b=Q+u1GptEfjlxuaebmaAv4baZ++nFRiH0WmIGQypJRtsJ99OAQ491RJOC9ZBUUTog7O4LY+NfLp3y8GetBC4dM1VzE4Hy6uhRxoSIPQqW078UBdEFHW3x7T3rzxqBqLTVr2IU3I+RElw4AtMVy8pfsvXaMcoBsSwHiKKeKMd5qoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746204946; c=relaxed/simple;
	bh=GNeGhze/d0IqBd35rQ7wW2xNehKHCmBz16mnzFHVYoM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NTj/ChvXsaGIOj8UgdZ770yMvJWPmnWNjrE5qtMhJCgJEaLmYEesV/OLZDMJ6Z9wFYC2y5qI+h//iAoVML3L4I9ZB/3+ibGUg/Uli/BUgun55e3wlns/OdAiTqT5vawp4y7wbYVL+vl/L6Iw2N8ALqiWD/Ia7h0BmM9IQwoaWsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WyBa23Gc; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-22c3407a87aso35565105ad.3;
        Fri, 02 May 2025 09:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746204942; x=1746809742; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Ql3U/ewtiWig9aIL+QxIB2EPrqmH+OkPP9/cyas0+6M=;
        b=WyBa23GcHRpZrgkypw3uWKaxCCcRX5mdnPQ9GSu+GDgMVAERJCRgVPl8qeDpFglWDK
         j9D74H0EtFuSlnPkotxBRD/J5qXIUx231T5zzWEsfMszeI4bkGG9K/kGV3pmmGcN3t8y
         /effOeETBMfHTm26kfumjqHrYawN7Bguc0/QZ6BQlHD0QJ/qsCi7zDNCTrmkNpn0EYLJ
         8rlTlO4IGYMU1ww4zOQGGDHP74a3lkwLEtc+e2GJMRwkvh6ZPumVC5/ITNYAJ0waK6Rn
         OGLTXvROPVkFVuU6b/UolKPYp64L3TQhNS2DRtxBLqrluaHtd6sXkHyU1oyQPW1l98tD
         8FLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746204942; x=1746809742;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ql3U/ewtiWig9aIL+QxIB2EPrqmH+OkPP9/cyas0+6M=;
        b=NENHNpjus9c38hq028PLXqc5zLNYxLiaR0mh6FdAQsUgZ9ORP84SVCFSuf0MG8hs4/
         RmXZTUSzG/xlNAwByQt6n2sk3RY8Sfu4QOySJ0blMuBAN3a/9UE116PN0OG8zPq/2NRY
         lJOoC7ZYVjza2I5aBWsNAvTeks9Iv/zgb1BCfU5+MhtnFuWdEvliqLMrff4AWPcJQvns
         J/U27Rq6Ta0vzeGpnm6rtK06gUBKWs6AGj371E+i3qY7LpZxhlEQjiMFFMfY0QU67eXQ
         /o+OYOnKZtakomDda4uNjxnOP2X5Qh4rFZ6NVJDYoIK2UnHs4OqqgZJK0IV/fziRjvBx
         ox1g==
X-Forwarded-Encrypted: i=1; AJvYcCXCzPTw9X+XRkhu4EmngbD78bzrKccDFQo9KFZzfKfUUWgmfbL/5AF4ZV/Bfv8CycqmVBm197Y9OUQzbltx@vger.kernel.org, AJvYcCXyXJer47ctnLvz0AXHQsG4kM1w4w5VHjoMxh+Hx+yThdh1sRUMA3r678c4gql5wBmQssFPybP2JSQF@vger.kernel.org
X-Gm-Message-State: AOJu0Yyi/zBXBF1+LYDbzB1Eksup+rPSwdGbtaJ4UkETgRegu0l5alHu
	xqhgY8c21YSimv4k4/ayZhYYLdwEaweMG15GAQOLY+wCY96xbxfV
X-Gm-Gg: ASbGncsys+LKdl3BQgOn/+7V4eIAEYl8AfeVnpW569qzpgJrfEenH564R8M8G5ZTIY1
	GStbGtKtCoGiaoJ/JeJbwtJ/G55FsbN8zHjbORs1naeJVeAi67zNNcchYUSkmlNS+BhJ8txDheB
	Me+AkHBtMsSJbZX++FZ8ASygdmygdZ6JWrFRw2N34nchf85f/lBFznyXuoGl8N7VgByiaGeabFD
	dQe7fDnfEUZ4BHNXeHCI2wBB9YBDxT3tU3YJFtkOrUHdNOsnPfSnaBrCyIaebLqu3Gav8SIxTMp
	4/y53nZ+Pz/sS1INUdB6nbIvc7GzyijXVfjoLzyN
X-Google-Smtp-Source: AGHT+IFrgZtiF8mQ5Tt0e/TqukoCBkkID1wBp1Z9l7z0z8ByiPbU3GT3h0ptI6jfahNlhQtIGVLrww==
X-Received: by 2002:a17:902:da89:b0:220:e5be:29c7 with SMTP id d9443c01a7336-22e10340202mr50409875ad.39.1746204942276;
        Fri, 02 May 2025 09:55:42 -0700 (PDT)
Received: from localhost ([216.228.127.130])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22e152293casm9868055ad.205.2025.05.02.09.55.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 May 2025 09:55:41 -0700 (PDT)
Date: Fri, 2 May 2025 12:55:39 -0400
From: Yury Norov <yury.norov@gmail.com>
To: Ian Rogers <irogers@google.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Arnd Bergmann <arnd@arndb.de>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jakub Kicinski <kuba@kernel.org>,
	Jacob Keller <jacob.e.keller@intel.com>, linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
	Leo Yan <leo.yan@arm.com>
Subject: Re: [PATCH v2 2/5] bitmap: Silence a clang -Wshorten-64-to-32 warning
Message-ID: <aBT5C81se-z-eQMe@yury>
References: <20250430171534.132774-1-irogers@google.com>
 <20250430171534.132774-3-irogers@google.com>
 <aBTs6yvKlCYYgU2O@yury>
 <CAP-5=fXqLh7RdUok5oqVwyGOWCH3fktmVeECdi4ENBWnEHeJYQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fXqLh7RdUok5oqVwyGOWCH3fktmVeECdi4ENBWnEHeJYQ@mail.gmail.com>

On Fri, May 02, 2025 at 09:43:12AM -0700, Ian Rogers wrote:
> On Fri, May 2, 2025 at 9:03 AM Yury Norov <yury.norov@gmail.com> wrote:
> >
> > Hi Ian,
> >
> > On Wed, Apr 30, 2025 at 10:15:31AM -0700, Ian Rogers wrote:
> > > The clang warning -Wshorten-64-to-32 can be useful to catch
> > > inadvertent truncation. In some instances this truncation can lead to
> > > changing the sign of a result, for example, truncation to return an
> > > int to fit a sort routine. Silence the warning by making the implicit
> > > truncation explicit. This isn't to say the code is currently incorrect
> > > but without silencing the warning it is hard to spot the erroneous
> > > cases.
> > >
> > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > ---
> > >  include/linux/bitmap.h | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
> > > index 595217b7a6e7..4395e0a618f4 100644
> > > --- a/include/linux/bitmap.h
> > > +++ b/include/linux/bitmap.h
> > > @@ -442,7 +442,7 @@ static __always_inline
> > >  unsigned int bitmap_weight(const unsigned long *src, unsigned int nbits)
> > >  {
> > >       if (small_const_nbits(nbits))
> > > -             return hweight_long(*src & BITMAP_LAST_WORD_MASK(nbits));
> > > +             return (int)hweight_long(*src & BITMAP_LAST_WORD_MASK(nbits));
> >
> > This should return unsigned int, I guess?
> 
> Hi Yury, I don't disagree. The issue there is that this could break
> printf flags, etc. reliant on the return type. I've tried to keep the
> patch minimal in this regard.

Not sure I understand... 

I mean just 
        return (unsigned int)hweight_long(...);

because the bitmap_weight return type is unsigned int. Do I miss
something?
 
> > Also, most of the functions you touch here have their copies in tools.
> > Can you please keep them synchronized?
> 
> Yes, I do most of my work on the perf tool in the tools directory and
> these patches come from adding -Wshorten-64-to-32 there due to a bug
> found in ARM code that -Wshorten-64-to-32 would have caught:
> https://lore.kernel.org/lkml/20250331172759.115604-1-leo.yan@arm.com/
> The most recent patch series for tools is:
> https://lore.kernel.org/linux-perf-users/20250430175036.184610-1-irogers@google.com/
> However, I wanted to get the kernel versions of these headers agreed
> before syncing them into the tools directory.

Yes, I'm in CC for that series, but I didn't find the changes for
bitmap_weight(), fls64() and other functions you touch in this series.
Anyways, it would be logical to sync tools with the mother kernel in
the same series.

