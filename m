Return-Path: <linux-arch+bounces-13725-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0128EB95933
	for <lists+linux-arch@lfdr.de>; Tue, 23 Sep 2025 13:09:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAD8A4A4601
	for <lists+linux-arch@lfdr.de>; Tue, 23 Sep 2025 11:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5160321299;
	Tue, 23 Sep 2025 11:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bqYTjiRB"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F5132144A
	for <linux-arch@vger.kernel.org>; Tue, 23 Sep 2025 11:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758625692; cv=none; b=FY+daL15/ctS1WfhrLbV5758o7j3QVlSn5FPkOruy84z4gi9fQX0o54CTX50ZhafUi6sgsPFJzey3j5dZh/iOaenBDZrmfr9lz3m8Ww22avrC0Hms33HngKthpdIutEywbiEsPikAnWSJGfosvJNZUs+JQ2kLdjVJ2ryIXjVhik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758625692; c=relaxed/simple;
	bh=/XZsuYZiVJXloC6rrE97OTbLdirXXVYnP1HJQkVSPy4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Sth9/r+JXKdy32YoZ2tnUf3tQAJo9BLISQYAX0QvYz2++6XAdKVbvXfW+INcUQhW/fUF2vf6JLTizpMubjnnX143EXmYkiqOxR9cbsAlUqJOCBUf+chSKjaKz0JOUveZhuG7Av80nwhrY3WfPzd1uzYa2WpvmIbCPQAwCO66+kM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bqYTjiRB; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-62fa84c6916so11287a12.0
        for <linux-arch@vger.kernel.org>; Tue, 23 Sep 2025 04:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758625689; x=1759230489; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V2nNizs4EXcS6KdJvj0JrfZmsBGMOILUvFCRBf/9eF8=;
        b=bqYTjiRBUd6WehS77qKkZZ/Jyt+yuisivITRGxPEcCqprD88Ot1ZsMINk4JzeqeC5w
         Jiozv2UR//8SsKYs2EvD9lH+91HjU1cOS1I6hJ6wZS1hHtU53Y8u/iOwepdXE3vS0nE8
         9NqyheTgpoh42f6xaE7kFXIn0gDIxSMVlHR61p/rYLGoV+VJE6kXxPAAeZDU5W6PTtPb
         wj7I75TPH32wHLvcqKdRd+AAZiZx7DKaVIeS6K0V4Ahm6lHQSHMFRtrcs66moGU7KRdA
         KolPLykc25/JiweeQhABKQoUzBvgR0tgSP09xmxt6P+dSfN/Zt8+5fRtqhoze8NUrbDp
         zE5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758625689; x=1759230489;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V2nNizs4EXcS6KdJvj0JrfZmsBGMOILUvFCRBf/9eF8=;
        b=WUjZs/JcQ8Ghde7aXYt8APc40xnwIYxXl21Fj7z00pc4eahJb8mVb4VGZ7HwlbJzFR
         fciGpwOjCdncVPS1SIdbuaTyfvwgUtJgPR0YXrpa2UAVwYI3sCUoJomcpe7TINgh5+jz
         10gnArkIYByCFUh+rDgtRgnqACo2JEzAChEUPxlLspm+OeRFmlLn+Nwc5ukzlzWL9TQj
         TgqNHferDa4j1MoCqhPKt3qhdUa7SMyo8LdByTQoMSUxwbHNO5vJkmSh7xuYghYm7ajy
         /nY84kZ0IgNDUpY/bP9b5g9o1lRcLCHalXGA9jWFQl5OAWGXXPqzj2tLMttMTlu4neE3
         bJNw==
X-Gm-Message-State: AOJu0Yx8uCIF8Jnc6qy66bmgq80UPFoOAZo1I+Gl0OaVuep0k1FcTiA/
	7WubQz/8VFloCgXk+bId+1BQkkVz7aVXFm3NDUqKmAoEi4ZTR53uJ/KwqtU9U0n5wbPImiIuzdZ
	jnRBhgooc4SnffFh9ol0TkSqcILPCjSoHv8ETpSMD
X-Gm-Gg: ASbGncu6YzKhI/2jzQw4LE3xN5s5cgbyAFc4Ih2Hm7Eis9fK7rRXoPym62Wt3JCWktL
	6FYZ4IyidjzzKjmSquKojnIbq2Xy7ULx9wYflI3XZgaLl4B+T3RlQREpO2JgsBzu69GPNtMQmQq
	8TqZTVrz1Q+z+ufN5NTSh7ZX3ZrkgQMc9DFvDSjWt++j+qGF67PMSnIDoE2L30WHTd6K9bt9dkz
	nkPlOyOAkQB
X-Google-Smtp-Source: AGHT+IHOG4WkpDAtV/b73oGn6Rwke1EUIyIWRMd8NKkWBm8ULAtIMX19l+qwsw2RlB89gRURbDqwg9zWE9ZKCbG8XBI=
X-Received: by 2002:a05:6402:1d1a:b0:633:2321:a07b with SMTP id
 4fb4d7f45d1cf-63466aa27aemr55515a12.0.1758625688454; Tue, 23 Sep 2025
 04:08:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250330164229.2174672-1-varadgautam@google.com>
 <CAOLDJO+=+hcz498KRc+95dF5y3hZdtm+3y35o2rBC9qAOF-vDg@mail.gmail.com>
 <CAOLDJOKiEmde5Max0BnTBVpNmfpm-wwYLJ4Etv8D2KZKPHyFzw@mail.gmail.com>
 <CAOLDJOJ=QcQ065UTAdGayO2kbpGMOwCtdEGVm8TvQO8Wf8CSMw@mail.gmail.com>
 <CAOLDJOJ98EccMJ4O3FyX4mSFtHnbQ4iwwXsHT2EbLL+KrXfvtw@mail.gmail.com> <f74d9899-6aba-4c8e-87b1-cd6ecc7772e6@app.fastmail.com>
In-Reply-To: <f74d9899-6aba-4c8e-87b1-cd6ecc7772e6@app.fastmail.com>
From: Varad Gautam <varadgautam@google.com>
Date: Tue, 23 Sep 2025 13:07:57 +0200
X-Gm-Features: AS18NWDiaK8IssKPSakKKBWc2hagHQKHETrpRj1q8Sp4WHHDh4oDk9ZMPOZEQX0
Message-ID: <CAOLDJO+8JApK5_qjtn+DhCnQoF+Lp-x1KP_QQvJUqecp744T1w@mail.gmail.com>
Subject: Re: [PATCH] asm-generic/io.h: Skip trace helpers if rwmmio events are disabled
To: Arnd Bergmann <arnd@arndb.de>
Cc: Linux-Arch <linux-arch@vger.kernel.org>, 
	Sai Prakash Ranjan <quic_saipraka@quicinc.com>, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hey Arnd,

On Sat, Jul 26, 2025 at 6:22=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> wrote=
:
>
> On Thu, Jul 24, 2025, at 13:49, Varad Gautam wrote:
> > On Wed, May 28, 2025 at 5:28=E2=80=AFPM Varad Gautam <varadgautam@googl=
e.com> wrote:
> >>
> >> On Mon, Apr 28, 2025 at 9:41=E2=80=AFPM Varad Gautam <varadgautam@goog=
le.com> wrote:
> >> >
> >> > On Mon, Apr 7, 2025 at 6:13=E2=80=AFPM Varad Gautam <varadgautam@goo=
gle.com> wrote:
> >> > >
> >> > > On Sun, Mar 30, 2025 at 6:42=E2=80=AFPM Varad Gautam <varadgautam@=
google.com> wrote:
> >> > > >
> >> > > > With `CONFIG_TRACE_MMIO_ACCESS=3Dy`, the `{read,write}{b,w,l,q}{=
_relaxed}()`
> >> > > > mmio accessors unconditionally call `log_{post_}{read,write}_mmi=
o()`
> >> > > > helpers, which in turn call the ftrace ops for `rwmmio` trace ev=
ents
> >> > > >
> >> > > > This adds a performance penalty per mmio accessor call, even whe=
n
> >> > > > `rwmmio` events are disabled at runtime (~80% overhead on local
> >> > > > measurement).
> >> > > >
> >> > > > Guard these with `tracepoint_enabled()`.
> >> > > >
> >> > > > Signed-off-by: Varad Gautam <varadgautam@google.com>
> >> > > > Fixes: 210031971cdd ("asm-generic/io: Add logging support for MM=
IO accessors")
> >> > > > Cc: <stable@vger.kernel.org>
> >> > >
> >> > > Ping.
> >> > >
> >> >
> >> > Ping.
> >> >
> >>
> >> Ping. Arnd, can this be picked up into the asm-generic tree?
> >>
> >
> > Ping.
>
> I'm sorry I keep missing this one. It's really too late again for
> the merge window, so it won't be in 6.17 either, but I've applied
> it locally in my asm-generic branch that I'm planning for 6.18
> so I hope I won't miss it again.
>

Can I follow this along somewhere? (I don't see it on arnd/asm-generic.git =
atm.)

The unnecessary log_*_mmio() calls are showing up on enough Pixel devices
as a CPU cycles wastage, and I'm sure other Androids see it too.

Thanks,
Varad

> I currently have nothing queued up for 6.17 at all, but I already
> have some of my own patches that I plan to submit for review after
> the merge window and merge through the asm-generic tree.
>
>      Arnd

