Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD9C41522B4
	for <lists+linux-arch@lfdr.de>; Wed,  5 Feb 2020 00:05:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727773AbgBDXFI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 4 Feb 2020 18:05:08 -0500
Received: from mail-yw1-f67.google.com ([209.85.161.67]:45445 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727730AbgBDXFI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 4 Feb 2020 18:05:08 -0500
Received: by mail-yw1-f67.google.com with SMTP id a125so497857ywe.12;
        Tue, 04 Feb 2020 15:05:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CtQoI/LKAUwNO+ZZKppoJ9ZQ580TzGNHe3s32y3FDcU=;
        b=ROF++/lvs9p/8idAHcjKAdmghF1+VCUBbVHaKGDi9MBAwf0jtZxjDmAhefCMbFFcfF
         JJ5TqbaSBgrBZUtkSpZknIT4ZwngTl5xKyLobK2PwiONvjY5qFiRXsI8TKENTCdGLB0k
         JeDEt+MyCyp/MufMtBDVzGzXvayfxep6thC+HD79wU2BUmfY92Z6fOjnp5tzZWEd1s50
         aYqwJ91vKPAfNFsZDmkoNDDx3kc9ewWD6zfGX+flcui6n0IvyhZmTzbMfY5tu8blD8Sq
         L/O/Ny0FQrWSWtxzIRTluF9XrEGjHgUiG6lEY9EoFPlNjp9+EHWioNdTe/BdCNStxidd
         8AeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CtQoI/LKAUwNO+ZZKppoJ9ZQ580TzGNHe3s32y3FDcU=;
        b=OOro2M3d2W4gEOglyRSRVtTxunBUPF8vLGWS4dwlEu3cV0IjKaMl8TiClkTTOSGUBX
         5/n8v1btS0VjSVa7kR6sfDwjoKrEgAt9aDBVeIUtZkXmU34eiVVw128196qqUTqKl9gV
         tmVfjzNbTkBakug9gGQ4tIHy7jPExW6BJ0Umq0vHTGE9lEskVJN3yzGUV1NLlb1YYo40
         tpO717Jr/2NSuXBsx+hDuttgabGX5gQuxfdGhoIDJnufoXWwROzzD8Zo1cjtaMhNpa4G
         APR7yPIu5Wy7S4uYVPH8plkKhJ1iNJMeKSScfg7NVh+Zr/0CgLVlLfo2USeLuyzlXFiS
         I9vA==
X-Gm-Message-State: APjAAAXy/LJ3xQiukab/tTVjEfzft+/QstH0d3GMwYTs9e8HgIqKL7t8
        IJw4H4qHDD3/SrhXpDukQCE=
X-Google-Smtp-Source: APXvYqzzDZuIfag6+O2rgaU5TBXO5um0JsgDsqG/E1/FIi9Cp90kPbNCkYrb0YCImwZKz0hf09LoEg==
X-Received: by 2002:a0d:c444:: with SMTP id g65mr7768022ywd.119.1580857507100;
        Tue, 04 Feb 2020 15:05:07 -0800 (PST)
Received: from [192.168.1.46] (c-73-88-245-53.hsd1.tn.comcast.net. [73.88.245.53])
        by smtp.gmail.com with ESMTPSA id j68sm10253052ywg.6.2020.02.04.15.05.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Feb 2020 15:05:06 -0800 (PST)
Subject: Re: [PATCH v2 6/7] kunit: Add 'kunit_shutdown' option
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
 <20200130230812.142642-7-brendanhiggins@google.com>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <143dcdac-b19a-8eff-b441-ba79f1873801@gmail.com>
Date:   Tue, 4 Feb 2020 17:05:05 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200130230812.142642-7-brendanhiggins@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 1/30/20 5:08 PM, Brendan Higgins wrote:
> From: David Gow <davidgow@google.com>
> 
> Add a new kernel command-line option, 'kunit_shutdown', which allows the
> user to specify that the kernel poweroff, halt, or reboot after
> completing all KUnit tests; this is very handy for running KUnit tests
> on UML or a VM so that the UML/VM process exits cleanly immediately
> after running all tests without needing a special initramfs.

kunit_shutdown needs to be added to Documentation/admin-guide/kernel-parameters.txt

-Frank

> 
> Signed-off-by: David Gow <davidgow@google.com>
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> Reviewed-by: Stephen Boyd <sboyd@kernel.org>
> ---
>  lib/kunit/executor.c                | 20 ++++++++++++++++++++
>  tools/testing/kunit/kunit_kernel.py |  2 +-
>  tools/testing/kunit/kunit_parser.py |  2 +-
>  3 files changed, 22 insertions(+), 2 deletions(-)
> 
> diff --git a/lib/kunit/executor.c b/lib/kunit/executor.c
> index 7fd16feff157e..a93821116ccec 100644
> --- a/lib/kunit/executor.c
> +++ b/lib/kunit/executor.c
> @@ -1,5 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0
>  
> +#include <linux/reboot.h>
>  #include <kunit/test.h>
>  
>  /*
> @@ -11,6 +12,23 @@ extern struct kunit_suite * const * const __kunit_suites_end[];
>  
>  #if IS_BUILTIN(CONFIG_KUNIT)
>  
> +static char *kunit_shutdown;
> +core_param(kunit_shutdown, kunit_shutdown, charp, 0644);
> +
> +static void kunit_handle_shutdown(void)
> +{
> +	if (!kunit_shutdown)
> +		return;
> +
> +	if (!strcmp(kunit_shutdown, "poweroff"))
> +		kernel_power_off();
> +	else if (!strcmp(kunit_shutdown, "halt"))
> +		kernel_halt();
> +	else if (!strcmp(kunit_shutdown, "reboot"))
> +		kernel_restart(NULL);
> +
> +}
> +
>  static void kunit_print_tap_header(void)
>  {
>  	struct kunit_suite * const * const *suites, * const *subsuite;
> @@ -42,6 +60,8 @@ int kunit_run_all_tests(void)
>  		}
>  	}
>  
> +	kunit_handle_shutdown();
> +
>  	if (has_test_failed)
>  		return -EFAULT;
>  
> diff --git a/tools/testing/kunit/kunit_kernel.py b/tools/testing/kunit/kunit_kernel.py
> index cc5d844ecca13..43314aa537d30 100644
> --- a/tools/testing/kunit/kunit_kernel.py
> +++ b/tools/testing/kunit/kunit_kernel.py
> @@ -141,7 +141,7 @@ class LinuxSourceTree(object):
>  		return True
>  
>  	def run_kernel(self, args=[], timeout=None, build_dir=''):
> -		args.extend(['mem=256M'])
> +		args.extend(['mem=256M', 'kunit_shutdown=halt'])
>  		process = self._ops.linux_bin(args, timeout, build_dir)
>  		with open(os.path.join(build_dir, 'test.log'), 'w') as f:
>  			for line in process.stdout:
> diff --git a/tools/testing/kunit/kunit_parser.py b/tools/testing/kunit/kunit_parser.py
> index 78b3bdd03b1e4..633811dd9bce8 100644
> --- a/tools/testing/kunit/kunit_parser.py
> +++ b/tools/testing/kunit/kunit_parser.py
> @@ -48,7 +48,7 @@ class TestStatus(Enum):
>  	FAILURE_TO_PARSE_TESTS = auto()
>  
>  kunit_start_re = re.compile(r'^TAP version [0-9]+$')
> -kunit_end_re = re.compile('List of all partitions:')
> +kunit_end_re = re.compile(r'reboot: System halted')
>  
>  def isolate_kunit_output(kernel_output):
>  	started = False
> 

