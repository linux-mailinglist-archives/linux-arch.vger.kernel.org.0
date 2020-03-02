Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9328A1765BE
	for <lists+linux-arch@lfdr.de>; Mon,  2 Mar 2020 22:16:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbgCBVQn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 2 Mar 2020 16:16:43 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:46126 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726846AbgCBVQn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 2 Mar 2020 16:16:43 -0500
Received: by mail-pl1-f193.google.com with SMTP id y8so280035pll.13;
        Mon, 02 Mar 2020 13:16:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=707JQcccZExSjQ1cG2+ME+5GhpTFiiOzPDZOM11Q128=;
        b=Wx9paDmHSp4xWfhx/DfIRVvf6rL3n8uUicBhfpLjw5f8G/eBmsYCqOG7N8ZuXupNmf
         rdbSrJ6qErAkMbNVgMXUUsSBYxHgiv/GlyAal69L/hnenxOTONbX4aqEEnJvd6T43Q0Z
         QRjOKpkiN8BHEWyjlNtUMfEaM8pwdjEaom99sOwwXFXqEytqTxiaEKOREenFoZszgUGi
         mCXSNHwBw6kjeHabrIttOORoS8SCOE28IO9v+aU/rKObusUUivdoWyidVU+B06g9+Oid
         gj74zbMA8eAT2fu8o+RyLNKqdW60Z2tm48WET8wore3K/9SGSY6X2xZam3H46ukFdvRl
         2pJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=707JQcccZExSjQ1cG2+ME+5GhpTFiiOzPDZOM11Q128=;
        b=DKmNiVnE1LUwxl+SP5O2MdeCUC3NKqtySGGsrPF7djZT2dZngQmdCKiAIenpIFC5me
         aog99ZOLh1sC8SkBPfZxfhTcHxdWvnAx/kRk84YQd/IUhKPPnetAJG5N3Z4CG5LuvrEl
         t2NyFrZMBeJeRe3slE9iJzfKlsLsQ3xNXs+FOWcEih1anK+VYo1OQSLinwbOqxh5NESx
         LU/tewQBIst7yTcpwm6TJOEPRvp2YIZ+J5vEpfSNvbg7g5IIE0TEFMKFLtbhsfFgeQg2
         briLMrIMu3cKot66MqXwF8w/DAU81rVnhUJ+jzEU+K+9JCkQn00ZOPljTqy5xSnMVvq4
         2ytQ==
X-Gm-Message-State: ANhLgQ2Mpowjzzl7VAh9kEaKaxahISTY8dBUsHX+zqz7gIODQ7Jxa7J5
        9BZW6mWw/5pWMXtwOKe7KLA=
X-Google-Smtp-Source: ADFU+vv8Sd1PEqvRWJ2m63xwCVr6MxSHIdfgCkefGodJS420ZPfzwUnmsuy8u+aYp11Q6DL+cKqPKQ==
X-Received: by 2002:a17:902:8a8e:: with SMTP id p14mr1015904plo.28.1583183802179;
        Mon, 02 Mar 2020 13:16:42 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id q17sm21738229pfg.123.2020.03.02.13.16.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 02 Mar 2020 13:16:41 -0800 (PST)
Date:   Mon, 2 Mar 2020 13:16:40 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Brendan Higgins <brendanhiggins@google.com>, jdike@addtoit.com,
        richard@nod.at, anton.ivanov@cambridgegreys.com, arnd@arndb.de,
        keescook@chromium.org, skhan@linuxfoundation.org,
        alan.maguire@oracle.com, yzaikin@google.com, davidgow@google.com,
        akpm@linux-foundation.org, rppt@linux.ibm.com,
        frowand.list@gmail.com, gregkh@linuxfoundation.org,
        sboyd@kernel.org, logang@deltatee.com,
        linux-um@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v3 0/7] kunit: create a centralized executor to dispatch
 all KUnit tests
Message-ID: <20200302211640.GA8364@roeck-us.net>
References: <20200228012036.15682-1-brendanhiggins@google.com>
 <20200302200337.GH11244@42.do-not-panic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200302200337.GH11244@42.do-not-panic.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Mar 02, 2020 at 08:03:37PM +0000, Luis Chamberlain wrote:
> Guenter,
> 
> are you still running your cross-architecture tests? If so any chance

Yes

> you can try this for your build tests?
> 

I didn't have KUNIT_TEST enabled to start with. I did that now, and
started a test run on mainline a minute ago. We'll see how that goes.

Afterwards, sure, I can run the series in a test branch. It would be great
if I can pick it up from a repository somewhere.

Guenter
