Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B0DD228C6E
	for <lists+linux-arch@lfdr.de>; Wed, 22 Jul 2020 01:02:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731353AbgGUXCJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 21 Jul 2020 19:02:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731288AbgGUXCI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 21 Jul 2020 19:02:08 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35BDFC0619DB
        for <linux-arch@vger.kernel.org>; Tue, 21 Jul 2020 16:02:07 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id d1so17072plr.8
        for <linux-arch@vger.kernel.org>; Tue, 21 Jul 2020 16:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=mcZTtXUZTypejTnIJ7xyZOrF3R3Meo9MjDufW96ubz8=;
        b=VsRIyxfZipyELzOOGXyC7A/mMrs+UsFQWvACDHx3vXVYKIkhRxZ4HCXXsj+7S+fOWa
         8anGBr/9l9CTXmpXhjjwZDPLxC3QwvXVFO4fexy9cxiQ9QGAOZubrWcoyJrYzkFEcKhg
         DQfT87xX2ICUsY9dXTAkQomNrlYlkjw0bzglLl/Rt77B2gvyJFRTqmIpTrmQfZTNcyZU
         J7QEyhCszj9q01oOxEerSe8+dH3gjgZVdfPLQDb9wAmSmlFaWx8tbS9p7hRlSXdx9CDn
         BVQEX7q+Ojd/1VHPtj7SK7vB8A+BOP9YRPzy0d3WSkrnyHv2vHTqXdKuZg2qi+faBXnz
         Io5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=mcZTtXUZTypejTnIJ7xyZOrF3R3Meo9MjDufW96ubz8=;
        b=d5WiO21RRyMCQuq41Rk02YnXgxZi3rYOhSEuHbIx6BX1Aj/mb9wdBYE3MFyXc4FBbt
         pvh/wTN2lx7bcuGFIOAHB+50q686QFAYFBvM7xJi1FpeaqnujZ/hZRcPbrukqZpPnelC
         jXCMd2VHWDDyE4BmwiBhMzbA6Z/7mbwwnHvdslSo+lN+pzHSFEbd42+NWHNUAWTzeg5t
         n54f5Yuktz37pjvkV7SwaSCevNAd1fIhSZsrcKylo6vOw4NhVWulC/Zs7FsyBawqxkvm
         mEMHXzOk7361siUX2ftWocCoHKZsQtKKiaYuBRIwmQd/+kymTL4SPEHoM370b2yZ1hpU
         oGjw==
X-Gm-Message-State: AOAM531vhAzbe280TGSpW8xsPzhjLQ3TKLG7M83tY203FM2gNg3pSVUA
        MiQiTmufcvB4o5CuA0TA3bxMlw==
X-Google-Smtp-Source: ABdhPJxNB+8714jhZkFUMp5+W+T+nSUMhVdE5+kOrwpP1g7VL9v49row44RpOFy391TezGadZfINuw==
X-Received: by 2002:a17:902:2:: with SMTP id 2mr24478726pla.288.1595372526421;
        Tue, 21 Jul 2020 16:02:06 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id t19sm18386515pgg.19.2020.07.21.16.02.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 16:02:05 -0700 (PDT)
Date:   Tue, 21 Jul 2020 16:02:05 -0700 (PDT)
X-Google-Original-Date: Tue, 21 Jul 2020 16:02:03 PDT (-0700)
Subject:     Re: [PATCH 3/6] riscv: include <asm/pgtable.h> in <asm/uaccess.h>
In-Reply-To: <20200710135706.537715-4-hch@lst.de>
CC:     nickhu@andestech.com, green.hu@gmail.com, deanbo422@gmail.com,
        Paul Walmsley <paul.walmsley@sifive.com>,
        akpm@linux-foundation.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Christoph Hellwig <hch@lst.de>
Message-ID: <mhng-2e6d1568-076d-40fc-988a-9d035d54af79@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, 10 Jul 2020 06:57:03 PDT (-0700), Christoph Hellwig wrote:
> To ensure TASK_SIZE is defined for USER_DS.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/riscv/include/asm/uaccess.h | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/riscv/include/asm/uaccess.h b/arch/riscv/include/asm/uaccess.h
> index 8ce9d607b53dce..22de922d6ecb2f 100644
> --- a/arch/riscv/include/asm/uaccess.h
> +++ b/arch/riscv/include/asm/uaccess.h
> @@ -8,6 +8,8 @@
>  #ifndef _ASM_RISCV_UACCESS_H
>  #define _ASM_RISCV_UACCESS_H
>
> +#include <asm/pgtable.h>		/* for TASK_SIZE */
> +
>  /*
>   * User space memory access functions
>   */

Acked-by: Palmer Dabbelt <palmerdabbelt@google.com>

Thanks!
