Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F8191756B5
	for <lists+linux-arch@lfdr.de>; Mon,  2 Mar 2020 10:16:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726956AbgCBJQl (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 2 Mar 2020 04:16:41 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:51163 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726654AbgCBJQl (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 2 Mar 2020 04:16:41 -0500
Received: by mail-pj1-f66.google.com with SMTP id nm14so1432561pjb.0;
        Mon, 02 Mar 2020 01:16:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ndch3h4URTloyii1gSOs74b+yGmOg265tPn81wcSc2E=;
        b=vL0VVsuaaoEsbUHMmRXA6lfSc7FopuGlr36i0AXnSjtq/HXbT/8a6v2h2NFzs7jmga
         DQNmZYmIN2qjCn4v4UprQ1hhz87Li5nLtHphVK3d096BA9X8u9jvsl+X1E12z9uDygY0
         tDZeDZt7dIcEa5iu/48Zcj9kqwt/Afy8lQ2vPLl7eyAB1mcmVl07n5BrFg1XH9SvUM4V
         cODnqdSWYkDAaS9/SYbnZvwG7/Jwq9o5rMX/rJPp73ybLwKm3V2HM/o4EREpet7DoAG4
         6ELWoIXedXfCwuV2u4nSq8sFAeFOZrb5Dfj1fao4CFdutyOVFG77o0e8I3Wc9gSbNNju
         9spQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ndch3h4URTloyii1gSOs74b+yGmOg265tPn81wcSc2E=;
        b=JtaB7Ms0nEuhvdP93a6hJUvzuveUZVF7UmB5QFjwRpWfwDw5l+VfEUn78J1DXQgUCm
         PPM5hqRJq8hzfNSHB5SWkVFnIk4lBHedNWQlz3xapvNef4abD65N8noAM2sUCIscGg/I
         qzmu8YNcW/d17tV4Ag4YDsPRbCu/Oa/g5YoK/sW0LxZ1javGScWgqQrXKTyConxspMP+
         YnDqTg+0i43T+8I7R88bLtMFvYn6EJDnSaOo3KpQ1Zgm/uhbxXME0ezxICqIf4xHODYU
         UMPxZXnQQA/ml2oBPP4jWrJKyTpaTUz8IY9LbqnMX5FrW4xUFnDWfw+6g7PTn1GG3X2H
         VDSQ==
X-Gm-Message-State: APjAAAXOMqsAKA9A/r9cwroLADx8KV3+JA8FSPBBsyiyJh/DQog4iJy0
        7+r8sha8z6i2zHGZiR2Km9Y=
X-Google-Smtp-Source: APXvYqxYIsfqZ+2k8oz/ngUWeeMoVuDFCKNrgGHaEoCYv0tsPO+VuDwJwr+REUi3DbiXhJ5trOFulQ==
X-Received: by 2002:a17:902:8ec9:: with SMTP id x9mr17070699plo.182.1583140599577;
        Mon, 02 Mar 2020 01:16:39 -0800 (PST)
Received: from localhost (g183.222-224-185.ppp.wakwak.ne.jp. [222.224.185.183])
        by smtp.gmail.com with ESMTPSA id p18sm21513722pjo.3.2020.03.02.01.16.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2020 01:16:38 -0800 (PST)
Date:   Mon, 2 Mar 2020 18:16:35 +0900
From:   Stafford Horne <shorne@gmail.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-mm@kvack.org, Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Guo Ren <guoren@kernel.org>, Brian Cain <bcain@codeaurora.org>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Sam Creasey <sammy@sammy.net>, Michal Simek <monstr@monstr.eu>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paulburton@kernel.org>,
        Nick Hu <nickhu@andestech.com>,
        Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Ley Foon Tan <ley.foon.tan@intel.com>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>,
        "David S. Miller" <davem@davemloft.net>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Guan Xuetao <gxt@pku.edu.cn>, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, nios2-dev@lists.rocketboards.org,
        openrisc@lists.librecores.org, linux-parisc@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-um@lists.infradead.org,
        linux-xtensa@linux-xtensa.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/special: Create generic fallbacks for pte_special()
 and pte_mkspecial()
Message-ID: <20200302091635.GK7926@lianli.shorne-pla.net>
References: <1583114190-7678-1-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1583114190-7678-1-git-send-email-anshuman.khandual@arm.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Mar 02, 2020 at 07:26:30AM +0530, Anshuman Khandual wrote:

> diff --git a/arch/openrisc/include/asm/pgtable.h b/arch/openrisc/include/asm/pgtable.h
> index 248d22d8faa7..7f3fb9ceb083 100644
> --- a/arch/openrisc/include/asm/pgtable.h
> +++ b/arch/openrisc/include/asm/pgtable.h
> @@ -236,8 +236,6 @@ static inline int pte_write(pte_t pte) { return pte_val(pte) & _PAGE_WRITE; }
>  static inline int pte_exec(pte_t pte)  { return pte_val(pte) & _PAGE_EXEC; }
>  static inline int pte_dirty(pte_t pte) { return pte_val(pte) & _PAGE_DIRTY; }
>  static inline int pte_young(pte_t pte) { return pte_val(pte) & _PAGE_ACCESSED; }
> -static inline int pte_special(pte_t pte) { return 0; }
> -static inline pte_t pte_mkspecial(pte_t pte) { return pte; }
>  
>  static inline pte_t pte_wrprotect(pte_t pte)
>  {

For openrisc bits:

Acked-by: Stafford Horne <shorne@gmail.com>
 
