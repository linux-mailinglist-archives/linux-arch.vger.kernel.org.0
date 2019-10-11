Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 65EE0D4418
	for <lists+linux-arch@lfdr.de>; Fri, 11 Oct 2019 17:25:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726521AbfJKPZj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 11 Oct 2019 11:25:39 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:46752 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727890AbfJKPZi (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 11 Oct 2019 11:25:38 -0400
Received: by mail-yb1-f193.google.com with SMTP id h202so3204240ybg.13
        for <linux-arch@vger.kernel.org>; Fri, 11 Oct 2019 08:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hjVVG+LCl45Ap93nqrjHPaMZ4hTq+jdNOcLl2h2isR4=;
        b=E0dKoxgvUXWjFVVVks6GzW0TjExH0yK1lnbi91wV8UOgJXhezVXn6TKlZ8HQUqA4LB
         Ocx5BzIjuxG958WumzE9PHeFIKmdin8uJ80H+haes7A8Uss5tac+84Bu78gsZut6QXAH
         lAk8SDxXuvS8brS+1lB1ksHLQ4k/RGyUL6wLn/UpINn7yR8VT+jswqGAyCr8ZhDTczre
         5iQpR0zvXXa+jUNmN6dDOszzNYTbsXpTuYHQnlbsTKD8jioNaXyu0auTjxbbs/cFails
         zGhGXYBrnMUWJ8wU2JABRejO0vxitMy0Ol37RK7oCzGgGTyKxkikYq8uCPF7weNSTt9/
         JvtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hjVVG+LCl45Ap93nqrjHPaMZ4hTq+jdNOcLl2h2isR4=;
        b=St3b6ZNkNirQ8nREFhaRXXM4PJbcZm0Sjcj4/bqWvBJTQP2iEUQsOetX08aK78DqSr
         bBLhYsqLIdqv/3KMpJxpbjqNweCi4ChdwmTTqstLFhiop5dH5dgD+0zafskNYsqfxRrs
         yoUsiMSEDwQus3Ql4g+HqFzQlTe7z3BEpMUeqayAomdWhpPUpCYLoU7+chX608aCUbh+
         7O7eak99oIkCAc7ZfISIqkWY/Xr85TWYWzmmaIERrSnv7HUEhOBrS69MnIX2xpTNe6Ql
         ZdZE2L1huglzK2b6updM0WNS+O1WVHmn7eX2FKr/OOITmsAxD5gw/0lrD1pky5KRAkNj
         nzDg==
X-Gm-Message-State: APjAAAW/zkY5I6xR6KjVY5zYhAK/8IlenpKws2BbwaCseYnQ0T1IndaX
        7NL/9ZICgDa4lI6/NSkznNJKFA5Ih7c=
X-Google-Smtp-Source: APXvYqysY7dY5L83dfJIuaCR944gcYiW6Lfi2SqxpcDRGH/9Id6HpLLJrRLEW2oTFhfQatKUSjZZtg==
X-Received: by 2002:a25:2d49:: with SMTP id s9mr9205759ybe.450.1570807536250;
        Fri, 11 Oct 2019 08:25:36 -0700 (PDT)
Received: from [192.168.1.44] (67.216.151.25.pool.hargray.net. [67.216.151.25])
        by smtp.gmail.com with ESMTPSA id t82sm2316781ywc.26.2019.10.11.08.25.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Oct 2019 08:25:35 -0700 (PDT)
Subject: Re: [PATCH v2 05/12] arm64: Basic Branch Target Identification
 support
To:     Mark Rutland <mark.rutland@arm.com>,
        Dave Martin <Dave.Martin@arm.com>
Cc:     linux-kernel@vger.kernel.org, Andrew Jones <drjones@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        =?UTF-8?Q?Kristina_Mart=c5=a1enko?= <kristina.martsenko@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Paul Elliott <paul.elliott@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sudakshina Das <sudi.das@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will.deacon@arm.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Amit Kachhap <amit.kachhap@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <1570733080-21015-1-git-send-email-Dave.Martin@arm.com>
 <1570733080-21015-6-git-send-email-Dave.Martin@arm.com>
 <20191011151028.GE33537@lakrids.cambridge.arm.com>
From:   Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <4e09ca54-f353-9448-64ed-4ba1e38c6ebc@linaro.org>
Date:   Fri, 11 Oct 2019 11:25:33 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191011151028.GE33537@lakrids.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 10/11/19 11:10 AM, Mark Rutland wrote:
> On Thu, Oct 10, 2019 at 07:44:33PM +0100, Dave Martin wrote:
>> @@ -730,6 +730,11 @@ static void setup_return
>>  	regs->regs[29] = (unsigned long)&user->next_frame->fp;
>>  	regs->pc = (unsigned long)ka->sa.sa_handler;
>>  
>> +	if (system_supports_bti()) {
>> +		regs->pstate &= ~PSR_BTYPE_MASK;
>> +		regs->pstate |= PSR_BTYPE_CALL;
>> +	}
>> +
> 
> I think we might need a comment as to what we're trying to ensure here.
> 
> I was under the (perhaps mistaken) impression that we'd generate a
> pristine pstate for a signal handler, and it's not clear to me that we
> must ensure the first instruction is a target instruction.

I think it makes sense to treat entry into a signal handler as a call.  Code
that has been compiled for BTI, and whose page has been marked with PROT_BTI,
will already have the pauth/bti markup at the beginning of the signal handler
function; we might as well verify that.

Otherwise sigaction becomes a hole by which an attacker can force execution to
start at any arbitrary address.


r~
