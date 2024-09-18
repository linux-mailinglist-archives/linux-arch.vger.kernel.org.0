Return-Path: <linux-arch+bounces-7355-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 52C7197C15A
	for <lists+linux-arch@lfdr.de>; Wed, 18 Sep 2024 23:23:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16A15282E1C
	for <lists+linux-arch@lfdr.de>; Wed, 18 Sep 2024 21:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52E1E18A6C5;
	Wed, 18 Sep 2024 21:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T4VQSuOf"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D116B172BDE;
	Wed, 18 Sep 2024 21:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726694576; cv=none; b=hIhXPz7pBR3OSk2peZBNYDeqOTlPLC7Ba+K90IuJmPuX/ReVehWYt7QL9L2d3hLVVM/Q0at1n4qhr94HVz2ICMUBy+hhSg1r66GfUrrofH08eawWYW4X51oDJvnJ5DnFg5M7Ny/1b68bdqbEyyBUcpSRyqp2NQqnX3Ddfqzs/Zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726694576; c=relaxed/simple;
	bh=AxTxj99dIVccR7LN4Pl4VKcLuuOVdN43YIHzdQiko2M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aIr8TZK48vT+JrFfrEXsKwm0Q+Mdx16AQPJuH5aCMvrsuckQ0ZYnTHrQuErctE0vxm9vs4DnZmvQct63lzPjBjIFlBOMegua1JMI7frmdQmXiW6thnO20HdX04RPWndMD/5t9jYz8DeS4+GIaHrDrXuQX909tojXUceJZV7ZBR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T4VQSuOf; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2da55ea8163so136410a91.1;
        Wed, 18 Sep 2024 14:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726694574; x=1727299374; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kOdXjoeQ4nEmJ8UMVlYl/8AvhkHTD6zkaDk+W7dD8fI=;
        b=T4VQSuOfHLgxhyqYp8xvV4WkfzM1vqhzqxi9610vRCJhl4EsmfD8LEnymKv5QDxnj1
         HfbvHRaNGcQ43ZZazg8synIlanfYJC1m2XLfxhJN//48pu7Mr3hmPwq4Hbn6ucMqc0K4
         qEvvLb1KX9+Wno5KrxORP504dGwLJXpJawThqS9px7cvOul6Xob6FDKXvQocOdGbrZgS
         gCu8Cskn1wkSA8BkOLPc3Rl3t3yqED+HnY0JVFR/71N4mnTDc60ZA74CGAN6x97Ie1UQ
         9j/0Je3cCPLV3GFeAllU9fAVcFbhTmHslyXUEFsI/OrzUwxo5HwyrgU2WighjRg2YD8Q
         LrjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726694574; x=1727299374;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kOdXjoeQ4nEmJ8UMVlYl/8AvhkHTD6zkaDk+W7dD8fI=;
        b=XankQ8KbTKhbBPVKVePr4qwRSZRqKpjsN9H7ipagbKwNINGEyYZrsCCgtb6ImpFgvf
         zx5rBLMjehgATEc7/6L/tul5ercUGZN5JhPhDsObKNtzHdfILxO5amawqnsVRjCsEiK8
         HD+cCrbIWlVBTsyzc7vKtijeu9dmSMcLfjGf+mkBpo26bZmhF/XSqJyqDxYoGWVbhAnk
         Xv6xl55oMA2V9VZQPgVDjWoe6jO9CSSCov/rjT4MPCfAqCPIm1m5KObV5u5s8stnt7wK
         ltaY8AHSD04Cg5PHm8TXhP33asIz8McNBg+v8k+3+LDtamyhGolMsbSXKYR/9lOtqUHc
         IbrA==
X-Forwarded-Encrypted: i=1; AJvYcCUzaaqEG1ODqhnZ+kg+r7z+3Jj7idkYrtXuwOcTMb/0aSnjFzyRIXYz8SjQHGLvzXyWyXvPKE4m3/enuW9j@vger.kernel.org, AJvYcCVbz56OPDKQ0ZgoPKS0tfFcVY4othw8RTCruOnXn4h9KySpH3qZZwWLSIIeQVVWlUph+Zg=@vger.kernel.org, AJvYcCVlR7etx48nGG8doOM1wiuZhC6vFVJVs8wMj2OxZiaqTENccDkDnNpaQNDtCP0Fjq8ENanYoXsf1YwNJw==@vger.kernel.org, AJvYcCXstS1ST/ST7/MLmLfCw2W8YvbQld+xkcZA4rfgnMhN/dTN5FEHbtin6btfdovOtJCv/nH/64gvle6B6m6mNrUothY6@vger.kernel.org
X-Gm-Message-State: AOJu0Yzojm1mcPEQRYumjRbBjjE1DqkaH0+XHTWF88zC5676mIGZ4laz
	xOoqe0InIIrBx2cQdrIcS4NSa/p2Usd2ZhCViR5q0nLWqcV38wWwnnxfQXxioiYNDrj47BDFxZb
	4HLKwOlasSS2f7vS4c4xgDFbI7yU=
X-Google-Smtp-Source: AGHT+IEGPQsCbfwy2x9UpqhHd4Kkjvl2bDFZeUZSzoulljt4aDiYCy2c2rxCKPyVUcQL6nh9Hkk7/uOcSXl9fewAuK8=
X-Received: by 2002:a17:90b:4c41:b0:2c9:3370:56e3 with SMTP id
 98e67ed59e1d1-2dba008304amr26880812a91.34.1726694574055; Wed, 18 Sep 2024
 14:22:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <172639136989.366111.11359590127009702129.stgit@devnote2>
In-Reply-To: <172639136989.366111.11359590127009702129.stgit@devnote2>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 18 Sep 2024 23:22:41 +0200
Message-ID: <CAEf4BzZAPjZEZR9m66hPr6srzJwuu=B8zu6cNhxe-7__5+LpHw@mail.gmail.com>
Subject: Re: [PATCH v15 00/19] tracing: fprobe: function_graph: Multi-function
 graph and fprobe on fgraph
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Florent Revest <revest@chromium.org>, linux-trace-kernel@vger.kernel.org, 
	LKML <linux-kernel@vger.kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	bpf <bpf@vger.kernel.org>, Sven Schnelle <svens@linux.ibm.com>, 
	Alexei Starovoitov <ast@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Alan Maguire <alan.maguire@oracle.com>, Mark Rutland <mark.rutland@arm.com>, 
	Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Guo Ren <guoren@kernel.org>, 
	linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 15, 2024 at 11:09=E2=80=AFAM Masami Hiramatsu (Google)
<mhiramat@kernel.org> wrote:
>
> Hi,
>
> Here is the 15th version of the series to re-implement the fprobe on
> function-graph tracer. The previous version is;
>
> https://lore.kernel.org/all/172615368656.133222.2336770908714920670.stgit=
@devnote2/
>
> This version rebased on Steve's calltime change[1] instead of the last
> patch in the previous series, and adds a bpf patch to add get_entry_ip()
> for arm64. Note that [1] is not included in this series, so please use
> the git branch[2].
>

With LPC and Kernel Recipes back-to-back I won't have time to look
through the code, but I did manage to run some benchmarks tonight, and
they look pretty good now, thanks! Seems like the kprobe regression is
gone, and kretprobes are a bit faster. So, nice work, thanks!

BEFORE
=3D=3D=3D=3D=3D=3D
kprobe         :   25.052 =C2=B1 0.032M/s
kprobe-multi   :   28.102 =C2=B1 0.167M/s
kretprobe      :   10.724 =C2=B1 0.008M/s
kretprobe-multi:   11.337 =C2=B1 0.054M/s

AFTER
=3D=3D=3D=3D=3D
kprobe         :   25.206 =C2=B1 0.026M/s
kprobe-multi   :   30.167 =C2=B1 0.148M/s
kretprobe      :   10.714 =C2=B1 0.016M/s
kretprobe-multi:   13.436 =C2=B1 0.328M/s

> [1] https://lore.kernel.org/all/20240914214805.779822616@goodmis.org/
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/mhiramat/linux.git/lo=
g/?h=3Dtopic/fprobe-on-fgraph
>

[...]

