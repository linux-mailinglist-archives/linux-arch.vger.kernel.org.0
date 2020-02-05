Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC39A152406
	for <lists+linux-arch@lfdr.de>; Wed,  5 Feb 2020 01:19:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727627AbgBEATJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 4 Feb 2020 19:19:09 -0500
Received: from mail-yw1-f68.google.com ([209.85.161.68]:37269 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727537AbgBEATJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 4 Feb 2020 19:19:09 -0500
Received: by mail-yw1-f68.google.com with SMTP id l5so786624ywd.4;
        Tue, 04 Feb 2020 16:19:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=NIMxNLCcbWdI9pD04SjD3Y49RygU2eutIYBAiu1d0NQ=;
        b=kNH/YUzawP+43dSMN7Q/MuLlyAhji6r3ufngpALGZyf5tggPBwRgsMIA6Hu/D9bA6A
         D7x8zshF5PASFC3oztn4phdjSD+oSVQjBPfSI/nUZ7jOlcJFF1eEuuffiqDyY1n1Us26
         vkojZ56eiO52mbJGxFN9ExLX6imGA1Ez6g6vgD2fTvDyxAGk4idW9EIBICRs2JA2ulWl
         gRAHC0S770XSNTKEY8Z425DSL3K7L+4jVSMfpeYFPNz/BrpcenLW5gF1lLxb0jwJDSpr
         +AOVSPDxb1FvEqvX4xW5h8DPPY4WxkqLZ5ryZ4KsFmmFuwggdX809RS0UzmthCSvxD59
         6DAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NIMxNLCcbWdI9pD04SjD3Y49RygU2eutIYBAiu1d0NQ=;
        b=UDlQHF8n6Kf3Q3UVUNb0lKKqLmbMAMVMSkB3fIBiWZVGOo+o2vBhMPKe5UCy1zoxL1
         Gt5CFm65uDuSBYfxJf+pd+Htj9rG7GAMw+t4YQlx+e4wATFBaC8l7dbITjul5B3EdqND
         psEsZsJBn7+3ccmeDkFkaBEWO33zahPi5v2upbofLV6MVtD7uKPE5EVEB9DItMQb9aT9
         DAeQTkmvM0dYiicYapHjJa13r23GnbOSOIeS5aB2Yz70GLKTN55ULnx059Y5jvosghL/
         15QlRC1AXKhxWxbfy3+jPE7C/BsyJgV8mWM+gsjOrDvLI7S4nBfCl9FA5d298w4ObY6H
         Tn9w==
X-Gm-Message-State: APjAAAXzCysOyIPMv5kjH4zuuTbrt+ynhda0UpMkAlMhUozir8dqC4dv
        vH6ItCGw2TraJ+qct5h40aQ=
X-Google-Smtp-Source: APXvYqwOMJ/fJzT9iHJ8EtyebqNOkpzqMGzGkLU+0qEGaS2WXqxmiJAiJRH2Fim/xt/KGKTmLPBAHA==
X-Received: by 2002:a81:a903:: with SMTP id g3mr7778923ywh.427.1580861948493;
        Tue, 04 Feb 2020 16:19:08 -0800 (PST)
Received: from [192.168.1.46] (c-73-88-245-53.hsd1.tn.comcast.net. [73.88.245.53])
        by smtp.gmail.com with ESMTPSA id y129sm10877046ywd.40.2020.02.04.16.19.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Feb 2020 16:19:08 -0800 (PST)
Subject: Re: [PATCH v2 7/7] Documentation: Add kunit_shutdown to
 kernel-parameters.txt
To:     Brendan Higgins <brendanhiggins@google.com>, jdike@addtoit.com,
        richard@nod.at, anton.ivanov@cambridgegreys.com, arnd@arndb.de,
        keescook@chromium.org, skhan@linuxfoundation.org,
        alan.maguire@oracle.com, yzaikin@google.com, davidgow@google.com,
        akpm@linux-foundation.org, rppt@linux.ibm.com
Cc:     gregkh@linuxfoundation.org, sboyd@kernel.org, logang@deltatee.com,
        mcgrof@kernel.org, knut.omang@oracle.com,
        linux-um@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
References: <20200130230812.142642-1-brendanhiggins@google.com>
 <20200130230812.142642-8-brendanhiggins@google.com>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <d187686e-a175-e30b-2af9-6e00822fed5c@gmail.com>
Date:   Tue, 4 Feb 2020 18:19:07 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200130230812.142642-8-brendanhiggins@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 1/30/20 5:08 PM, Brendan Higgins wrote:
> Add kunit_shutdown, an option to specify that the kernel shutsdown after
> running KUnit tests, to the kernel-parameters.txt documentation.
> 
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> Reviewed-by: Stephen Boyd <sboyd@kernel.org>
> ---
>  Documentation/admin-guide/kernel-parameters.txt | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index ade4e6ec23e03..522fd8bdec949 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -2054,6 +2054,13 @@
>  			0: force disabled
>  			1: force enabled
>  
> +	kunit_shutdown	[KERNEL UNIT TESTING FRAMEWORK] Shutdown kernel after
> +			running tests.

                        running built-in tests.  Tests configured as modules will not be run.

My wording might not be consistent with KUnit terminology regarding "built-in" and "modules".
Feel free to properly word smith.


> +			Default:	(flag not present) don't shutdown
> +			poweroff:	poweroff the kernel after running tests
> +			halt:		halt the kernel after running tests
> +			reboot:		reboot the kernel after running tests
> +
>  	kvm.ignore_msrs=[KVM] Ignore guest accesses to unhandled MSRs.
>  			Default is 0 (don't ignore, but inject #GP)
>  
> 

