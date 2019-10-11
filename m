Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6DC27D40F5
	for <lists+linux-arch@lfdr.de>; Fri, 11 Oct 2019 15:19:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728252AbfJKNTx (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 11 Oct 2019 09:19:53 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40186 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727950AbfJKNTx (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 11 Oct 2019 09:19:53 -0400
Received: by mail-wm1-f65.google.com with SMTP id b24so10197274wmj.5
        for <linux-arch@vger.kernel.org>; Fri, 11 Oct 2019 06:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=3WqnFBtN99txOjHW8qFZ7VvrrzF2BjnHQs3onyzMvPs=;
        b=bH5CG0AW9kXASvJA2EuMJnKaKD7Fbs1GwNRinWUWTNTapEP8RrIptCMP1an49xbekJ
         H/3qiouCwCwQmtjegXgBKGYHApR1xTo11NC5DYgYsPTOeQGRoDPvtPnRqKg84HcAlqvO
         XRvXTQoaIKeYYrxABxAnEh0Qvzhqn4By2pZusdHwszJXbIb/NFeogtxxx6vNknOUUPy5
         RfDnt/1a4BbZriu5/MsIqONZBAi1MKpClV3PE8YTfrl7OOtrUxEVgeQSqiDMBL92j54u
         u4ZwCTTwFqwMacJBhOAq3ppU8n5FD0zr7DkSg35RtBGQhA8ISMcqUAddCt9zb4UvoSUc
         H1aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=3WqnFBtN99txOjHW8qFZ7VvrrzF2BjnHQs3onyzMvPs=;
        b=p98WcLUZemvTrFDbt2OiqH5pIJd3m7zltTOpG2n5Wa0XdEPLv0xRw39CM/NMDi+5CW
         EboffOg7eBWJsxT3QcK+bY4w32w8ZjFhfuEHkDWdfFG/VGf8dUeGHnDA1WB7iHF9BCCS
         NlZ0l3RaWLSROFsef30+3F6FeTTcJTKZhoaKCwY0bbUCI1f2WhZnnoWlsChj6Bg4dfGp
         omzCmWrUTbKd2wqUU/oodP+QD3sTq/PorEysF4LenDhn2t2g34JuZUz3E3DJsIKShUO7
         qd6Vhgx4Pgn2Tk8Rei7/ugy5ZkIrxp+LKt+DKHlqnpXlBplvDBuK+CesQEwW2oE0zkRz
         RYTQ==
X-Gm-Message-State: APjAAAVjpWJMLoPHToLrRx3V9BTxTl4cAqjM5m8Z4AEN/bI9PnLFHL++
        MfebM7IM3oEVe+qfe9T6RrkuxA==
X-Google-Smtp-Source: APXvYqynWfJQdfki/cjqANCLobcJdHZS0I5wCNhJ1JZtTd6660Unv8vERen1T4YJoCu1nFkIJXw1vg==
X-Received: by 2002:a7b:ca54:: with SMTP id m20mr3360919wml.142.1570799990277;
        Fri, 11 Oct 2019 06:19:50 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
        by smtp.gmail.com with ESMTPSA id f143sm12497795wme.40.2019.10.11.06.19.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2019 06:19:49 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
        by zen.linaroharston (Postfix) with ESMTP id E1BD11FF87;
        Fri, 11 Oct 2019 14:19:48 +0100 (BST)
References: <1570733080-21015-1-git-send-email-Dave.Martin@arm.com>
 <1570733080-21015-5-git-send-email-Dave.Martin@arm.com>
User-agent: mu4e 1.3.5; emacs 27.0.50
From:   Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To:     Dave Martin <Dave.Martin@arm.com>
Cc:     linux-kernel@vger.kernel.org, Andrew Jones <drjones@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Kristina =?utf-8?Q?Mart=C5=A1enko?= <kristina.martsenko@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Paul Elliott <paul.elliott@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Richard Henderson <richard.henderson@linaro.org>,
        Sudakshina Das <sudi.das@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will.deacon@arm.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Amit Kachhap <amit.kachhap@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 04/12] arm64: docs: cpu-feature-registers: Document
 ID_AA64PFR1_EL1
In-reply-to: <1570733080-21015-5-git-send-email-Dave.Martin@arm.com>
Date:   Fri, 11 Oct 2019 14:19:48 +0100
Message-ID: <87zhi7l8qz.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


Dave Martin <Dave.Martin@arm.com> writes:

> Commit d71be2b6c0e1 ("arm64: cpufeature: Detect SSBS and advertise
> to userspace") exposes ID_AA64PFR1_EL1 to userspace, but didn't
> update the documentation to match.
>
> Add it.
>
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>
>
> ---
>
> Note to maintainers:
>
>  * This patch has been racing with various other attempts to fix
>    the same documentation in the meantime.
>
>    Since this patch only fixes the documenting for pre-existing
>    features, it can safely be dropped if appropriate.
>
>    The _new_ documentation relating to BTI feature reporting
>    is in a subsequent patch, and needs to be retained.
> ---
>  Documentation/arm64/cpu-feature-registers.rst | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/arm64/cpu-feature-registers.rst b/Documentatio=
n/arm64/cpu-feature-registers.rst
> index 2955287..b86828f 100644
> --- a/Documentation/arm64/cpu-feature-registers.rst
> +++ b/Documentation/arm64/cpu-feature-registers.rst
> @@ -168,8 +168,15 @@ infrastructure:
>       +------------------------------+---------+---------+
>
>
> -  3) MIDR_EL1 - Main ID Register
> +  3) ID_AA64PFR1_EL1 - Processor Feature Register 1
> +     +------------------------------+---------+---------+
> +     | Name                         |  bits   | visible |
> +     +------------------------------+---------+---------+
> +     | SSBS                         | [7-4]   |    y    |
> +     +------------------------------+---------+---------+
> +
>
> +  4) MIDR_EL1 - Main ID Register
>       +------------------------------+---------+---------+
>       | Name                         |  bits   | visible |
>       +------------------------------+---------+---------+
> @@ -188,7 +195,7 @@ infrastructure:
>     as available on the CPU where it is fetched and is not a system
>     wide safe value.
>
> -  4) ID_AA64ISAR1_EL1 - Instruction set attribute register 1
> +  5) ID_AA64ISAR1_EL1 - Instruction set attribute register 1

If I'm not mistaken .rst has support for auto-enumeration if the #
character is used. That might reduce the pain of re-numbering in future.

>
>       +------------------------------+---------+---------+
>       | Name                         |  bits   | visible |
> @@ -210,7 +217,7 @@ infrastructure:
>       | DPB                          | [3-0]   |    y    |
>       +------------------------------+---------+---------+
>
> -  5) ID_AA64MMFR2_EL1 - Memory model feature register 2
> +  6) ID_AA64MMFR2_EL1 - Memory model feature register 2
>
>       +------------------------------+---------+---------+
>       | Name                         |  bits   | visible |
> @@ -218,7 +225,7 @@ infrastructure:
>       | AT                           | [35-32] |    y    |
>       +------------------------------+---------+---------+
>
> -  6) ID_AA64ZFR0_EL1 - SVE feature ID register 0
> +  7) ID_AA64ZFR0_EL1 - SVE feature ID register 0
>
>       +------------------------------+---------+---------+
>       | Name                         |  bits   | visible |


--
Alex Benn=C3=A9e
