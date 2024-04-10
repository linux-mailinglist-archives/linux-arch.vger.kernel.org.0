Return-Path: <linux-arch+bounces-3550-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FB6E8A033C
	for <lists+linux-arch@lfdr.de>; Thu, 11 Apr 2024 00:21:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9D2C1F22C79
	for <lists+linux-arch@lfdr.de>; Wed, 10 Apr 2024 22:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28220184119;
	Wed, 10 Apr 2024 22:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TZtD/VsK"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D3F12FF7C
	for <linux-arch@vger.kernel.org>; Wed, 10 Apr 2024 22:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712787704; cv=none; b=Ll795hq1hwyFvJ9hOortieboaVo3+kS4KW65NLHA40850/0RdFKOo27FarRNRqcElFTDRVV/6yu3FTUpCR+t5X1usmGr3bHZ4xwSCU44dA8IAMSMLv/chi2X8sFHndwogobamqobKMCy+3cL/Jyxp3ppaXdFIFQeW5PsqTBqVRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712787704; c=relaxed/simple;
	bh=SQyfDI1p8mtUjtI3BfAFLemnAtOtjnfc4UlRkBuRrI0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hETtSix4dWmrUlUDFZSKWAKFTY0FtGjCOGF7vTltuJAW+7//35bNstmBmo8kV8RuBhkcWI+krxBjAlNAjGhU5S17DidxxU+4Akgr+D4LtKMIDkCKHhaYF+huCyx3/L6pfH6Bn0jAxTCoYHO4Qf45EwTx8cZmHxOW5yAr3p2vAXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TZtD/VsK; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1e3f17c64daso30127925ad.3
        for <linux-arch@vger.kernel.org>; Wed, 10 Apr 2024 15:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712787702; x=1713392502; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:user-agent
         :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UQ9C1Cr3AvASEU86K/hlf2OO0iCRrNUVuyjVHdlWHE4=;
        b=TZtD/VsK+Z8FsufyHKK/cZe7E4ZmfhA0V+FOSy/jn7ulFlKbyySF3NETO59AtLHzhp
         doGV91IEpxMkF9SBODmmYXHD341v8hn4G/Vfd+9bOh0UJq2PaKxcGTeYRzVorRB0qwVw
         x1hcl1K4kMuZogOvwNTxutBc+aO71hcFDGXv7aF81b+5KWNyVl+WqpKWXqveFcriOiUx
         IyQWA2AszsSAoz3tINgNr7OFHdwWAwDPTFLCwBWe+uqJU/i28mSd+Yo8xVA/EQwBLIAk
         z8MR3Ky0ScgmcoOjR9do1rZAug5w1B7yu4NIaqETouvs8g4e0p8XAw2/kAui2Q/4Tflm
         xKBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712787702; x=1713392502;
        h=content-transfer-encoding:mime-version:message-id:date:user-agent
         :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UQ9C1Cr3AvASEU86K/hlf2OO0iCRrNUVuyjVHdlWHE4=;
        b=u9x9x3r9zSrp2B3I+55sguuz96xjGick8MkLdCPfAG4vOCf8xSFj36Wghhz7SfYtcC
         5LwL86REbiL9xMH7pXqfkUOZKV3JunhE4w6I4yvXLqc5pl8QdnCxwaHQ9ye/bC8R25Ai
         w5Ec/RH1ui8s9+glWUV/O68U0G/EJ8i/ujKRVwwfs7yplzAycIlqZMBA0Rb6GUGT7UOU
         mr7/zHFGAVkdBCnmyy+lAB8nsbBrqc+e0fgFnf/KWMQgbPr93RGTqtbltPL6+Jw5NqTM
         1n7/4ytuKzfeJxN5iKK5z8e2Gj957XATnmb5tIHY401swzxO+Q+j5WEdnn6+NN4azmjO
         1W+g==
X-Forwarded-Encrypted: i=1; AJvYcCWMf0QDvuxs4Wt9++MXO5zDAS6ZjtY25h27WcyyFwKIyK6d117ws4D5yYqPxXXuHqR7zxcYbqWtyuz2AxmZdJNlKJVWb3X/ZsMUyQ==
X-Gm-Message-State: AOJu0YzvGcbFbwnh6dqcrKZwcERCqjMZnB6GIOnGMKXFSkecoGD8XmNg
	gAW6SkC0L+2ZQsX+FCuTrXFZVjyvwCu/iL2Wdi6/Wube+uiJDTmg+NtWEQ0WO8E=
X-Google-Smtp-Source: AGHT+IEyXjz5iWD+JzMbxman4f15iRJH7qvrzDvYbxC6J1pXkyjcclFUtxHEFXG2Dt+UzEnUxH7BCA==
X-Received: by 2002:a17:902:e810:b0:1e3:e081:e7f5 with SMTP id u16-20020a170902e81000b001e3e081e7f5mr5334384plg.66.1712787701595;
        Wed, 10 Apr 2024 15:21:41 -0700 (PDT)
Received: from localhost ([2804:214:8686:5e16:705e:67c9:b3ef:a558])
        by smtp.gmail.com with ESMTPSA id q8-20020a170902b10800b001e107222eb5sm39198plr.191.2024.04.10.15.21.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 15:21:41 -0700 (PDT)
From: Thiago Jung Bauermann <thiago.bauermann@linaro.org>
To: Samuel Holland <samuel.holland@sifive.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
  linux-arm-kernel@lists.infradead.org,  x86@kernel.org,
  linux-kernel@vger.kernel.org,  linux-arch@vger.kernel.org,
  linuxppc-dev@lists.ozlabs.org,  linux-riscv@lists.infradead.org,
  Christoph Hellwig <hch@lst.de>,  loongarch@lists.linux.dev,
  amd-gfx@lists.freedesktop.org,  Alex Deucher <alexander.deucher@amd.com>
Subject: Re: [PATCH v4 13/15] drm/amd/display: Use ARCH_HAS_KERNEL_FPU_SUPPORT
In-Reply-To: <20240329072441.591471-14-samuel.holland@sifive.com> (Samuel
	Holland's message of "Fri, 29 Mar 2024 00:18:28 -0700")
References: <20240329072441.591471-1-samuel.holland@sifive.com>
	<20240329072441.591471-14-samuel.holland@sifive.com>
User-Agent: mu4e 1.12.2; emacs 29.3
Date: Wed, 10 Apr 2024 19:21:37 -0300
Message-ID: <87wmp4oo3y.fsf@linaro.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


Hello,

Samuel Holland <samuel.holland@sifive.com> writes:

> Now that all previously-supported architectures select
> ARCH_HAS_KERNEL_FPU_SUPPORT, this code can depend on that symbol instead
> of the existing list of architectures. It can also take advantage of the
> common kernel-mode FPU API and method of adjusting CFLAGS.
>
> Acked-by: Alex Deucher <alexander.deucher@amd.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>

Unfortunately this patch causes build failures on arm with allyesconfig
and allmodconfig. Tested with next-20240410.

Error with allyesconfig:

$ make -j 8 \
    O=3D$HOME/.cache/builds/linux-cross-arm \
    ARCH=3Darm \
    CROSS_COMPILE=3Darm-linux-gnueabihf-
make[1]: Entering directory '/home/bauermann/.cache/builds/linux-cross-arm'
    =E2=8B=AE
arm-linux-gnueabihf-ld: drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.=
o: in function `dcn20_populate_dml_pipes_from_context':
dcn20_fpu.c:(.text+0x20f4): undefined reference to `__aeabi_l2d'
arm-linux-gnueabihf-ld: dcn20_fpu.c:(.text+0x210c): undefined reference to =
`__aeabi_l2d'
arm-linux-gnueabihf-ld: dcn20_fpu.c:(.text+0x2124): undefined reference to =
`__aeabi_l2d'
arm-linux-gnueabihf-ld: dcn20_fpu.c:(.text+0x213c): undefined reference to =
`__aeabi_l2d'
arm-linux-gnueabihf-ld: drivers/gpu/drm/amd/display/dc/dml/calcs/dcn_calcs.=
o: in function `pipe_ctx_to_e2e_pipe_params':
dcn_calcs.c:(.text+0x390): undefined reference to `__aeabi_l2d'
arm-linux-gnueabihf-ld: drivers/gpu/drm/amd/display/dc/dml/calcs/dcn_calcs.=
o:dcn_calcs.c:(.text+0x3a4): more undefined references to `__aeabi_l2d' fol=
low
arm-linux-gnueabihf-ld: drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.o:=
 in function `optimize_configuration':
dml2_wrapper.c:(.text+0xcbc): undefined reference to `__aeabi_d2ulz'
arm-linux-gnueabihf-ld: drivers/gpu/drm/amd/display/dc/dml2/dml2_translatio=
n_helper.o: in function `populate_dml_plane_cfg_from_plane_state':
dml2_translation_helper.c:(.text+0x9e4): undefined reference to `__aeabi_l2=
d'
arm-linux-gnueabihf-ld: dml2_translation_helper.c:(.text+0xa20): undefined =
reference to `__aeabi_l2d'
arm-linux-gnueabihf-ld: dml2_translation_helper.c:(.text+0xa58): undefined =
reference to `__aeabi_l2d'
arm-linux-gnueabihf-ld: dml2_translation_helper.c:(.text+0xa90): undefined =
reference to `__aeabi_l2d'
make[3]: *** [/home/bauermann/src/linux/scripts/Makefile.vmlinux:37: vmlinu=
x] Error 1
make[2]: *** [/home/bauermann/src/linux/Makefile:1165: vmlinux] Error 2
make[1]: *** [/home/bauermann/src/linux/Makefile:240: __sub-make] Error 2
make[1]: Leaving directory '/home/bauermann/.cache/builds/linux-cross-arm'
make: *** [Makefile:240: __sub-make] Error 2

The error with allmodconfig is slightly different:

$ make -j 8 \
    O=3D$HOME/.cache/builds/linux-cross-arm \
    ARCH=3Darm \
    CROSS_COMPILE=3Darm-linux-gnueabihf-
make[1]: Entering directory '/home/bauermann/.cache/builds/linux-cross-arm'
    =E2=8B=AE
ERROR: modpost: "__aeabi_d2ulz" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] unde=
fined!
ERROR: modpost: "__aeabi_l2d" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefi=
ned!
make[3]: *** [/home/bauermann/src/linux/scripts/Makefile.modpost:145: Modul=
e.symvers] Error 1
make[2]: *** [/home/bauermann/src/linux/Makefile:1876: modpost] Error 2
make[1]: *** [/home/bauermann/src/linux/Makefile:240: __sub-make] Error 2
make[1]: Leaving directory '/home/bauermann/.cache/builds/linux-cross-arm'
make: *** [Makefile:240: __sub-make] Error 2

--
Thiago

