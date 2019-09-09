Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C4E9ADCA7
	for <lists+linux-arch@lfdr.de>; Mon,  9 Sep 2019 18:05:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728900AbfIIQFo (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 9 Sep 2019 12:05:44 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:41569 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727495AbfIIQFo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 9 Sep 2019 12:05:44 -0400
Received: by mail-pg1-f194.google.com with SMTP id x15so8078446pgg.8;
        Mon, 09 Sep 2019 09:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hCEUuZTmH7JZSazgZauiNORQYEOZ09QkyRcwVeQ8pb8=;
        b=lElCnuM/yk8u5jMO6suEdZBYPmjwu8chy23l7E6HJm4jvZ1dFx8vmP7GAVOP5wKIBp
         WgliA0r1aKN4fNChItK6BSgX06QM0LLGrZt0TvdcmxRCkuNIzJYajKGxUSretj1tbHPb
         jtNhGSWvesra0WBCfz4+SQ0DT3AHDn2Ku0cHTHssk6Jxu1f5b2zGpzjHVFdo+Prpb8MG
         g+eJf2EPcrTpeKGIWgLWqe9KBpx8oMdRgxus0PF5vnoGeDO3l/ZHA2OBut0HTD1W3ToO
         C3d05bhLrhY20xyTj+tLb3R/mwsJEZHVc5w+JIeMTihLl2qBWj5jPs71+q9kdrtXRlpA
         CHwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hCEUuZTmH7JZSazgZauiNORQYEOZ09QkyRcwVeQ8pb8=;
        b=UPQy4/GGbh9AvTZaRdckfLk7oX4FP/xQ5GbgmYM2JyCM/z7UWogueFer3Sfj6EVxe2
         4oMaNkCB2KV/oxN/x4wXBKcDh/SS01mQb90Wh6pPHpPZt+NC2GJ81plD7EQXUQcXfVOH
         wFytcAYIfHE+kFg2++fAtJf4P8lZ9o2QQD/XTYGn9EUH6ovbz0AD+69+//D5TTjqMxXw
         bH84EzIE+aENIBqy1BXNdG2bZ6v87pxz2QHwGQyy56u+cjI5L0DMCKim7QEI7axn2Ivy
         VqorzoZp59VebOA4M0CBRVnGKdVcthvxBUrtvuDnqE5yk3rkV0DDP5VtaJwfyabVW76z
         074w==
X-Gm-Message-State: APjAAAXcKzYjqFCksz+j9yVh25ADZC4w61xFtjxYQRXRSNCB96r8W6L9
        B440CSPzLROeVzg7IWnWgek=
X-Google-Smtp-Source: APXvYqy5qweVioephEKiH0izUHIYnTdxGqMdTN4qo3BtjRl9Wwi0YFrcMjmeztZHWUiwS6zU92mPGg==
X-Received: by 2002:a17:90a:2243:: with SMTP id c61mr33978pje.39.1568045143137;
        Mon, 09 Sep 2019 09:05:43 -0700 (PDT)
Received: from localhost ([121.137.63.184])
        by smtp.gmail.com with ESMTPSA id x8sm14913863pfm.35.2019.09.09.09.05.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2019 09:05:42 -0700 (PDT)
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Date:   Tue, 10 Sep 2019 01:05:39 +0900
To:     20190819234111.9019-8-keescook@chromium.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Peter Zijlstra <peterz@infradead.org>,
        Drew Davenport <ddavenport@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Feng Tang <feng.tang@intel.com>,
        Petr Mladek <pmladek@suse.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Borislav Petkov <bp@suse.de>,
        YueHaibing <yuehaibing@huawei.com>, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 7/7] bug: Move WARN_ON() "cut here" into exception
 handler
Message-ID: <20190909160539.GA989@tigerII.localdomain>
References: <201908200943.601DD59DCE@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201908200943.601DD59DCE@keescook>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On (08/20/19 09:47), Kees Cook wrote:
[..]
> @@ -181,6 +181,15 @@ enum bug_trap_type report_bug(unsigned long bugaddr, struct pt_regs *regs)
>  		}
>  	}
>  
> +	/*
> +	 * BUG() and WARN_ON() families don't print a custom debug message
> +	 * before triggering the exception handler, so we must add the
> +	 * "cut here" line now. WARN() issues its own "cut here" before the
> +	 * extra debugging message it writes before triggering the handler.
> +	 */
> +	if ((bug->flags & BUGFLAG_NO_CUT_HERE) == 0)
> +		printk(KERN_DEFAULT CUT_HERE);

Shouldn't this be pr_warn() or pr_crit()?

	-ss
