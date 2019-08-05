Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A2448218E
	for <lists+linux-arch@lfdr.de>; Mon,  5 Aug 2019 18:21:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728838AbfHEQVK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 5 Aug 2019 12:21:10 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40558 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728842AbfHEQVK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 5 Aug 2019 12:21:10 -0400
Received: by mail-wm1-f66.google.com with SMTP id v19so73624097wmj.5;
        Mon, 05 Aug 2019 09:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TN/L4zHfsTTS5T9aYyjvYkrI5ioXyxeBkpV2BWKvaS0=;
        b=aCOesO8xB/7z2UhU/c85p8TZAMZawKQTbZFe1DIAuiK6FXB2q91l24t1qs6Yk3lbrK
         MpCVMje9CyBDBWQ81YL9Hd/a1V9puj/GMzLePtSh+OSVPUzdjvk4sMSBq6h4gJlEXaR6
         9r/uR6FHLD1VcoIISWg8pplwqbNkDgjsRNmj8Ugoex33PK4J+r7zwP589krwrJv51rTH
         NGRKBsF8Rx5sryS/ErdazYIUbeaJG5YjnyCsYacmMwNN/fA76VYyuduoI8HlzEyXR4BT
         AGMphvt8jX+0BHADBF6oAOV0cW4npebs1QmnAgTy4F8NRUWoIpPOyMsZIil3g1YgXxrI
         +YDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TN/L4zHfsTTS5T9aYyjvYkrI5ioXyxeBkpV2BWKvaS0=;
        b=CetuokqOIwXyQXf6Hdjf5eEwBRdrLo1UqI1NyEXOkgj+/HSPSbN5nM9tunEc8H57II
         B3uYU/ZmwSxUYigrnUqgOsN6C4EZjPgWFQY1WUCyYRsxBbNns/w+OGFRYUQflCr9UiYY
         HbwQFJdHUERrGrAabv+pdWBNAomiQw1nm5RB3tUijSkQyn940J8Ljtg9YytCddIS3y3U
         CcrHUqXurE7Mj6lLG3qBPvaWf/iYfsSWh4rHJucWkRBqlU8FAbBAiP6QQsriux+JtfcW
         xg+W/3UIcY+nWFeqoVhlAP9kU/vciBuKXgdTWHzHLwGYiJ7lfQ9eBUFrremCv2z8Wwx0
         iwGQ==
X-Gm-Message-State: APjAAAVYL0w1GyrU/kj5eusWjKybQHlJs+kqnQvN0US6in/fykn04rkN
        rcxE5nmQT1cPHnZgnkMbLrg=
X-Google-Smtp-Source: APXvYqxX4W2FlNBX/QB3dsoh1PhFjBYG5J6cWfzh0exoe8SWrWK7woW6sWKb+lDwWpCSJgFNty0VJg==
X-Received: by 2002:a1c:1f4e:: with SMTP id f75mr18846272wmf.137.1565022067638;
        Mon, 05 Aug 2019 09:21:07 -0700 (PDT)
Received: from aparri ([167.220.197.45])
        by smtp.gmail.com with ESMTPSA id c78sm118033247wmd.16.2019.08.05.09.21.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Aug 2019 09:21:06 -0700 (PDT)
Date:   Mon, 5 Aug 2019 18:21:00 +0200
From:   Andrea Parri <parri.andrea@gmail.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Akira Yokosawa <akiyks@gmail.com>, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Daniel Lustig <dlustig@nvidia.com>
Subject: Re: [PATCH] MAINTAINERS: Update e-mail address for Andrea Parri
Message-ID: <20190805162100.GA2368@aparri>
References: <20190805121517.4734-1-parri.andrea@gmail.com>
 <76010b66-a662-5b07-a21d-ed074d7d2194@gmail.com>
 <20190805151545.GA1615@aparri>
 <1565018618.3341.6.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1565018618.3341.6.camel@HansenPartnership.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Aug 05, 2019 at 08:23:38AM -0700, James Bottomley wrote:
> On Mon, 2019-08-05 at 17:15 +0200, Andrea Parri wrote:
> > > Why don't you also add an entry in .mailmap as Will did in commit
> > > c584b1202f2d ("MAINTAINERS: Update my email address to use
> > > @kernel.org")?
> > 
> > I considered it but could not understand its purpose...  Maybe you
> > can explain it to me?  ;-) (can resend with this change if
> > needed/desired).
> 
> man git-shortlog gives you the gory detail, but its use is to "coalesce
> together commits by the same person in the shortlog, where their name
> and/or email address was spelled differently."  The usual way this
> happens is that people have the name that appears in the From field
> with and without initials.

Thanks for the remarks, James.  Given this, I'm okay with the submitted
version (i.e., no change to .mailmap).

  Andrea
