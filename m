Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9B5F2CDCF4
	for <lists+linux-arch@lfdr.de>; Thu,  3 Dec 2020 19:03:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729059AbgLCSB2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 3 Dec 2020 13:01:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:48768 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725987AbgLCSB2 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 3 Dec 2020 13:01:28 -0500
X-Gm-Message-State: AOAM5321f7DpYRc/3XljT4snBNXu4t92Z7Cy1NX1ZuuS6hMURgggg1BS
        q2eCvx4HnYdZH3LWN5wXFxgZ/avBPjK0X/AyUv4=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607018447;
        bh=FABGuImVXsV+nr09JVj+zQ9EBUfuYv8QZ4jBa/qWBac=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=bt+9JRnhQoLVYlUpusbbJNU+Ng5xMD90OOXgJXqRmzPVaVUWlSo+PK5EIwXw7LlmJ
         JrQz8RNpPhriWaWZtESgVLrqIvAZ4A48bS8lYWf7oL+ym7QRzuLtGlfoCLi0rHHEhy
         9g5P5balbrxwlRJY3S7h6RZIjrZdxyvD5LIs9DE3PU9m1sFKzRuveJlmz9UwBnWnm9
         shff21k87Gv0K/qKvlOhxypWbeINmJZI/RO+9lvo7QjuHmVKrfx14LvGISOzznmfd1
         kXPa/+iMg1TcdluFPcA8cVWDLWHflkf9/coRITc0QiIaA4zvPQIIZefBK239cmxJ5k
         nSKbGd2RGArvw==
X-Google-Smtp-Source: ABdhPJww/O/H+p+GzCiMKDAw50e0c47HIgejwRdl9Wx7k1zFogrRwzl/MT69w0GZmNtYyrPjsCHPQjEM6YLRwx8fzP4=
X-Received: by 2002:a05:6830:22d2:: with SMTP id q18mr276973otc.305.1607018446511;
 Thu, 03 Dec 2020 10:00:46 -0800 (PST)
MIME-Version: 1.0
References: <20201203170529.1029105-1-maskray@google.com>
In-Reply-To: <20201203170529.1029105-1-maskray@google.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Thu, 3 Dec 2020 19:00:30 +0100
X-Gmail-Original-Message-ID: <CAK8P3a3XiScgpL2cGy_e8-zK0U48Z0VMLJWDYKRM+BRUFC0TSg@mail.gmail.com>
Message-ID: <CAK8P3a3XiScgpL2cGy_e8-zK0U48Z0VMLJWDYKRM+BRUFC0TSg@mail.gmail.com>
Subject: Re: [PATCH] firmware_loader: Align .builtin_fw to 8
To:     Fangrui Song <maskray@google.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        linux-arch <linux-arch@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Dec 3, 2020 at 6:05 PM 'Fangrui Song' via Clang Built Linux
<clang-built-linux@googlegroups.com> wrote:
>
> arm64 references the start address of .builtin_fw (__start_builtin_fw)
> with a pair of R_AARCH64_ADR_PREL_PG_HI21/R_AARCH64_LDST64_ABS_LO12_NC
> relocations. The compiler is allowed to emit the
> R_AARCH64_LDST64_ABS_LO12_NC relocation because struct builtin_fw in
> include/linux/firmware.h is 8-byte aligned.
>
> The R_AARCH64_LDST64_ABS_LO12_NC relocation requires the address to be a
> multiple of 8, which may not be the case if .builtin_fw is empty.
> Unconditionally align .builtin_fw to fix the linker error.
>
> Fixes: 5658c76 ("firmware: allow firmware files to be built into kernel image")
> Link: https://github.com/ClangBuiltLinux/linux/issues/1204
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Fangrui Song <maskray@google.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>

I found the same thing in randconfig testing, but you beat me to
sending the fix.
