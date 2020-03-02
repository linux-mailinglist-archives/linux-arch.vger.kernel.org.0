Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A243176485
	for <lists+linux-arch@lfdr.de>; Mon,  2 Mar 2020 21:00:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726728AbgCBUAc (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 2 Mar 2020 15:00:32 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:44841 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbgCBUAc (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 2 Mar 2020 15:00:32 -0500
Received: by mail-pl1-f196.google.com with SMTP id d9so201459plo.11;
        Mon, 02 Mar 2020 12:00:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eha5O4PDESWCMGJ9xv9C6hsbviURSXHrEZj1b6AN74w=;
        b=mP+Vqs9OGp83mqOrPBaLryKSYTLw9nChmF01OoCfPTBTFWl+ERguoPPjfaeWcoAvjk
         RWrdL9j2iE1AY6HmUciIc/0qixCGnvrWHo7TZv+2Kq1df0y+Pu0pv5a0MDCmCRTOOTgG
         wBCpHrrcdy+fFT5Kb96S3Dms6VK7jMR4onS09/4+o0dsRYqjmy2+wit41RCwf7Lfn4ui
         RT5o0no4C0OMdf53O2OgdKtB4vWzorNCU/0XPZ25SBbmdV9aZTYTmsUjYRk2KPgzHC6R
         vN87uBLX0PR8KV/q63ksbv+fMShfVOjS/T4Ez5QylNSW8bVeA7cBbS33mxgODHCub1YW
         bOUg==
X-Gm-Message-State: ANhLgQ294+fuLMYeHjdMqxrdqSeOohQ5JA52rR7f1m617lE4QeX3YIEB
        0yYX8HqjLpt87B5J71Q3p+CfmkBkRRE=
X-Google-Smtp-Source: ADFU+vtuBEA5RFTwmgEPxMVETCPNW0efmSmnHAxCShQAfQUWpkiYAg9vQ83ecTjj51b/s1wKzCokOw==
X-Received: by 2002:a17:90a:928a:: with SMTP id n10mr124327pjo.194.1583179231233;
        Mon, 02 Mar 2020 12:00:31 -0800 (PST)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id u12sm22392960pgr.3.2020.03.02.12.00.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2020 12:00:29 -0800 (PST)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 39EE7413C3; Mon,  2 Mar 2020 20:00:27 +0000 (UTC)
Date:   Mon, 2 Mar 2020 20:00:27 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com,
        arnd@arndb.de, keescook@chromium.org, skhan@linuxfoundation.org,
        alan.maguire@oracle.com, yzaikin@google.com, davidgow@google.com,
        akpm@linux-foundation.org, rppt@linux.ibm.com,
        frowand.list@gmail.com, gregkh@linuxfoundation.org,
        sboyd@kernel.org, logang@deltatee.com, knut.omang@oracle.com,
        linux-um@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 4/7] init: main: add KUnit to kernel init
Message-ID: <20200302200027.GG11244@42.do-not-panic.com>
References: <20200130230812.142642-1-brendanhiggins@google.com>
 <20200130230812.142642-5-brendanhiggins@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200130230812.142642-5-brendanhiggins@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jan 30, 2020 at 03:08:09PM -0800, Brendan Higgins wrote:
> Remove KUnit from init calls entirely, instead call directly from
> kernel_init().
> 
> Co-developed-by: Alan Maguire <alan.maguire@oracle.com>
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> Reviewed-by: Stephen Boyd <sboyd@kernel.org>

Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>

In particular the placement and strategy matches my expectations and
allows us to think of __init as a separate beast, as we should.

  Luis
