Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 922AC2C61B7
	for <lists+linux-arch@lfdr.de>; Fri, 27 Nov 2020 10:31:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727983AbgK0Jau (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 27 Nov 2020 04:30:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725989AbgK0Jat (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 27 Nov 2020 04:30:49 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C047C0613D1;
        Fri, 27 Nov 2020 01:30:49 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id w24so5886187wmi.0;
        Fri, 27 Nov 2020 01:30:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nugmvnf9RyCLTrUTV0QpRDumZd95otaQgvkhBHEAu7E=;
        b=NlBZ/29o2yYLP8MbXhcI0F/PK0kEPTH3DFAdsLeeBcKpyteYi9dRQF9ylidoQVa8mm
         wDQo91JF0o+zGG+JQfgfK6BkZjX82P8EjLsRWx/5cqEzKRROufYECgf+j0pw6mGYPkUH
         sR993CVob6DqaGsTSWrdsPcNVJRt4903vj/s1xKyfqcmpI+ndEIR6sAVLvmHTKwojyeS
         1FmpUy0S5XSL/DisUf+Y50goYPvscoOF0CpFIXeENbqCBbwbUYP8yJGdaXkBr/PSGiuZ
         bWXkBs0Zb29qWAvBFFe12QRmj0orYSJxdMIl6TUic2Kw6MKlS8ATWm/rFrS8g+sEJLvb
         xCJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nugmvnf9RyCLTrUTV0QpRDumZd95otaQgvkhBHEAu7E=;
        b=QGr3Y1ljEWL8CMjFMbMaoQa/PJKiiZlGdy6YdDPAnKnZ9sfM++T1aiMuNufnVV+y3k
         8DryLpCibbrQbKKps2O+/lUX5YxmdzLjSa8HQdcRbBwDEEvrsUPw9Fk2zCngFmO2Outa
         VjyBExtTOIzYxdUB1pkwREvOxvpcFATSAU9mwtfag6RKAAhRadr4VPMFdbtkqOQhSjlU
         dJ8V2N+s0vbav1BeNWTJ3AhYGMwGr2byIESSeUaaZLkSAtIZYWDIxQNKw5BbaBYrsFcQ
         pG5Elcvpx3PkFvwbgYfOWYsU/CMXdp59/a/081whZy27YWme5AjMsRnHn9zWApBOKX3b
         dXdQ==
X-Gm-Message-State: AOAM533MNR7rrOFmXawy8NpEUf/wpCn/dNbrdXPAyhjaAuXvqTJat8Q5
        ls3i+OKuWM/uiFZc7ZuZ6GkqiHvPLO32KQ==
X-Google-Smtp-Source: ABdhPJwBs+sLle0BSQ86bLNV9Pc6YbzoxSFdD/QjRGIfOKtQxVLou0Ml7WPz3t0ZVfryaCsqHyBg0Q==
X-Received: by 2002:a7b:c34a:: with SMTP id l10mr7798201wmj.125.1606469446708;
        Fri, 27 Nov 2020 01:30:46 -0800 (PST)
Received: from ?IPv6:2001:a61:24b3:de01:7310:e730:497d:ea6a? ([2001:a61:24b3:de01:7310:e730:497d:ea6a])
        by smtp.gmail.com with ESMTPSA id l23sm11535934wmh.40.2020.11.27.01.30.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Nov 2020 01:30:45 -0800 (PST)
Cc:     mtk.manpages@gmail.com, tglx@linutronix.de, mingo@kernel.org,
        luto@kernel.org, x86@kernel.org, len.brown@intel.com,
        dave.hansen@intel.com, hjl.tools@gmail.com, Dave.Martin@arm.com,
        mpe@ellerman.id.au, tony.luck@intel.com, ravi.v.shankar@intel.com,
        libc-alpha@sourceware.org, linux-arch@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        Fenghua Yu <fenghua.yu@intel.com>
Subject: Re: [PATCH v2 2/4] x86/elf: Support a new ELF aux vector
 AT_MINSIGSTKSZ
To:     Borislav Petkov <bp@suse.de>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Dave Martin <Dave.Martin@arm.com>
References: <20201119190237.626-1-chang.seok.bae@intel.com>
 <20201119190237.626-3-chang.seok.bae@intel.com>
 <20201126174418.GA29770@zn.tnic>
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Message-ID: <7b2b1f7f-75e5-01ab-7571-71340825d299@gmail.com>
Date:   Fri, 27 Nov 2020 10:30:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201126174418.GA29770@zn.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hey Dave Marin,

On 11/26/20 6:44 PM, Borislav Petkov wrote:
> On Thu, Nov 19, 2020 at 11:02:35AM -0800, Chang S. Bae wrote:
>> Historically, signal.h defines MINSIGSTKSZ (2KB) and SIGSTKSZ (8KB), for
>> use by all architectures with sigaltstack(2). Over time, the hardware state
>> size grew, but these constants did not evolve. Today, literal use of these
>> constants on several architectures may result in signal stack overflow, and
>> thus user data corruption.
>>
>> A few years ago, the ARM team addressed this issue by establishing
>> getauxval(AT_MINSIGSTKSZ), such that the kernel can supply at runtime value
>> that is an appropriate replacement on the current and future hardware.
>>
>> Add getauxval(AT_MINSIGSTKSZ) support to x86, analogous to the support
>> added for ARM in commit 94b07c1f8c39 ("arm64: signal: Report signal frame
>> size to userspace via auxv").
> 
> I don't see it documented here:
> 
> https://git.kernel.org/pub/scm/docs/man-pages/man-pages.git/tree/man3/getauxval.3
> 
> Dunno, now that two architectures will have it, maybe that is good
> enough reason to document it.
> 
> Adding Michael.

Commit 94b07c1f8c39 was your, Dave. Might I convince you to write a 
patch for getauxval(3)?

Thanks,


Michael


-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
