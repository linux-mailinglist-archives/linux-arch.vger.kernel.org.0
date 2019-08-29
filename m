Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E975AA2068
	for <lists+linux-arch@lfdr.de>; Thu, 29 Aug 2019 18:12:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726973AbfH2QMO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 29 Aug 2019 12:12:14 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46560 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727161AbfH2QMN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 29 Aug 2019 12:12:13 -0400
Received: by mail-pf1-f196.google.com with SMTP id q139so2353757pfc.13
        for <linux-arch@vger.kernel.org>; Thu, 29 Aug 2019 09:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PTQEC1Y4Yke23JK/LTgM0w8mgR2qZy0PBRnUbbY2XIo=;
        b=jEkJhc78PLM/JgFtQZWk7kdLuecagNe2WAYo89y8WuOW4zoGzT+kbSB8NIBe0zcalQ
         8PuF7Tdx7O8kY3LHOmHoCLfdJE91HQsCRyH1tciyLHfk3TBVMVq54nZfsIqsE4hgd3fB
         +OG0j04f8N9mNquyfOwl+bczuWP6l61lZjAEI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PTQEC1Y4Yke23JK/LTgM0w8mgR2qZy0PBRnUbbY2XIo=;
        b=RbzM9AkYxWP4qGacx13UOeeJU7pUbGwgSDV2pdzlQBzoD97ZWtgbiH6/Vw97j+FHmY
         Ntf+4Ut13F6lvDoFX176+CqESvSYHXUddudQMhZkkjUpDZlhn4HtjcC7zhhbBaNwRy85
         h+7GzMuzZw8ccx3+W875rH23TmKHNs4OUj7EZqBoGYBimFqpZwti7+dF+RxmHpTt7b66
         1AN4cbRpHXyRAUf8nV4YfFVVT7CZviJquT+xK7JB7Yjs0kcLP9bTr/n3MBy63TmhmrAt
         8JXpCv8oxBnAG6d0RTxqHGVHhwtxPS3eS5cuaCcC4oGeekHRhLoFoqocV08x2M1yGK9m
         FOPQ==
X-Gm-Message-State: APjAAAXBzkSpwdD9dIu9RJg8c8CnfXLt0RcbBrL1QK0odPArdthAeGQm
        P00PTdlI5GtqLQlT9AUj1nmaYg==
X-Google-Smtp-Source: APXvYqy1FKWow3z/gmrxsTdklap8cVSHO9/ZQ8Lf2Lm5FnOpYJcBns/BeEGMcIZIyZEJa9XDM04jcg==
X-Received: by 2002:a63:ff66:: with SMTP id s38mr9209438pgk.363.1567095133110;
        Thu, 29 Aug 2019 09:12:13 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 1sm3891410pfx.56.2019.08.29.09.12.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2019 09:12:11 -0700 (PDT)
Date:   Thu, 29 Aug 2019 09:12:10 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
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
Message-ID: <201908290910.BA3ED6BDEF@keescook>
References: <201908200943.601DD59DCE@keescook>
 <20190822155611.a1a6e26db99ba0876ba9c8bd@linux-foundation.org>
 <86003539-18ec-f2ff-a46f-764edb820dcd@c-s.fr>
 <201908241206.D223659@keescook>
 <4c1ed94a-4dd0-e5cb-0b87-397b512d465e@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4c1ed94a-4dd0-e5cb-0b87-397b512d465e@c-s.fr>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Aug 29, 2019 at 06:55:59AM +0200, Christophe Leroy wrote:
> Euh ... only received this mail yesterday. Same for the other answer.

Yeah, my outbound mail was busted. :(

> I think you wanted to use In-reply-to:
> [...]
> But still, Andrew is seing double ... And me as well :)
> 
> Fixes: Fixes:

I had a lot of failures in that email. :)

Thank you Andrew for cleaning this up.

-- 
Kees Cook
