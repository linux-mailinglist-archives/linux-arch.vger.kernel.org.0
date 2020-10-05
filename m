Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E65A4283818
	for <lists+linux-arch@lfdr.de>; Mon,  5 Oct 2020 16:44:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725911AbgJEOo3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 5 Oct 2020 10:44:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726352AbgJEOo0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 5 Oct 2020 10:44:26 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9A9BC0613A7
        for <linux-arch@vger.kernel.org>; Mon,  5 Oct 2020 07:44:24 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id g3so9727115qtq.10
        for <linux-arch@vger.kernel.org>; Mon, 05 Oct 2020 07:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NIPvw8e1heuwMKuiOcUyxto/CHGsF04EOz1itR69nNQ=;
        b=cDltzreSvmKHasVP3qz8D7gEjIMIpYVbydvudTIc7UnmM2uZZIQmxeyIDV13AHU20b
         lejw9pOPvN5XSioyhdXPD3md7iOgNH/8YNGOFiMEPr5aqtFf/NVAJxc/RWyprr5CY57D
         9FYIwELFv5jEd5B5gc6CepLCU7943Sdj1RT3I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NIPvw8e1heuwMKuiOcUyxto/CHGsF04EOz1itR69nNQ=;
        b=M5kowgxUNBiwGSSqRSlfZzAeGfhUXT4+OQS+NtM+B/TSI1OPHcQ+epXlbzXrAYTH2m
         HogUKXknDdL/b8gYZ4/bGlzgC/gtJuTfoFyLIQ30FDYlS47Dho5JmH2cy3XAV/iys3+r
         QtxI8ECrcoufGj4RZbQkHFm1T15XwydYd7g4sGA3p9lYIkQ8Jd0JSEtpQDfxo9SBhT4r
         8ZtTxVl4WBL/H/iESDnhK0bwyEg9e4hqmkRk/AKp7vO2p9Y/nuFIyjFxxvD6u/eNWvL+
         G6Qas3LPuwD9N+jhX4A/3I1lonx73jWX3g06UM+r2BBaIvi96wA25yETe8u0ClTQ6sCV
         IpDw==
X-Gm-Message-State: AOAM533RvuMZM7OTZDBRm5uTTuGRhrBjUo1JuHQ5+7Mxl0ktIzCIGvEr
        TtAs8pKigD2g6ZLnT0ZsYEtz0g==
X-Google-Smtp-Source: ABdhPJxTF+6qQlaN6mNtASaz9cwRdEycr27ZrgJNp2KPaVaehyLs5/DnPs64AVUOGl/HF6q0dD0YUw==
X-Received: by 2002:ac8:760f:: with SMTP id t15mr158142qtq.35.1601909063978;
        Mon, 05 Oct 2020 07:44:23 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id k22sm190690qkk.13.2020.10.05.07.44.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2020 07:44:23 -0700 (PDT)
Date:   Mon, 5 Oct 2020 10:44:22 -0400
From:   joel@joelfernandes.org
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Alan Stern <stern@rowland.harvard.edu>, parri.andrea@gmail.com,
        will@kernel.org, peterz@infradead.org, boqun.feng@gmail.com,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, akiyks@gmail.com, dlustig@nvidia.com,
        viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: Re: Litmus test for question from Al Viro
Message-ID: <20201005144422.GB524504@google.com>
References: <20201001045116.GA5014@paulmck-ThinkPad-P72>
 <20201001161529.GA251468@rowland.harvard.edu>
 <20201001213048.GF29330@paulmck-ThinkPad-P72>
 <20201003132212.GB318272@rowland.harvard.edu>
 <20201004233146.GP29330@paulmck-ThinkPad-P72>
 <20201005023846.GA359428@rowland.harvard.edu>
 <20201005140353.GW29330@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201005140353.GW29330@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Oct 05, 2020 at 07:03:53AM -0700, Paul E. McKenney wrote:
> On Sun, Oct 04, 2020 at 10:38:46PM -0400, Alan Stern wrote:
> > On Sun, Oct 04, 2020 at 04:31:46PM -0700, Paul E. McKenney wrote:
> > > Nice simple example!  How about like this?
> > > 
> > > 							Thanx, Paul
> > > 
> > > ------------------------------------------------------------------------
> > > 
> > > commit c964f404eabe4d8ce294e59dda713d8c19d340cf
> > > Author: Alan Stern <stern@rowland.harvard.edu>
> > > Date:   Sun Oct 4 16:27:03 2020 -0700
> > > 
> > >     manual/kernel: Add a litmus test with a hidden dependency
> > >     
> > >     This commit adds a litmus test that has a data dependency that can be
> > >     hidden by control flow.  In this test, both the taken and the not-taken
> > >     branches of an "if" statement must be accounted for in order to properly
> > >     analyze the litmus test.  But herd7 looks only at individual executions
> > >     in isolation, so fails to see the dependency.
> > >     
> > >     Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
> > >     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > > 
> > > diff --git a/manual/kernel/crypto-control-data.litmus b/manual/kernel/crypto-control-data.litmus
> > > new file mode 100644
> > > index 0000000..6baecf9
> > > --- /dev/null
> > > +++ b/manual/kernel/crypto-control-data.litmus
> > > @@ -0,0 +1,31 @@
> > > +C crypto-control-data
> > > +(*
> > > + * LB plus crypto-control-data plus data
> > > + *
> > > + * Result: Sometimes
> > > + *
> > > + * This is an example of OOTA and we would like it to be forbidden.
> > > + * The WRITE_ONCE in P0 is both data-dependent and (at the hardware level)
> > > + * control-dependent on the preceding READ_ONCE.  But the dependencies are
> > > + * hidden by the form of the conditional control construct, hence the 
> > > + * name "crypto-control-data".  The memory model doesn't recognize them.
> > > + *)
> > > +
> > > +{}
> > > +
> > > +P0(int *x, int *y)
> > > +{
> > > +	int r1;
> > > +
> > > +	r1 = 1;
> > > +	if (READ_ONCE(*x) == 0)
> > > +		r1 = 0;
> > > +	WRITE_ONCE(*y, r1);
> > > +}
> > > +
> > > +P1(int *x, int *y)
> > > +{
> > > +	WRITE_ONCE(*x, READ_ONCE(*y));
> > > +}
> > > +
> > > +exists (0:r1=1)
> > 
> > Considering the bug in herd7 pointed out by Akira, we should rewrite P1 as:
> > 
> > P1(int *x, int *y)
> > {
> > 	int r2;
> > 
> > 	r = READ_ONCE(*y);
> > 	WRITE_ONCE(*x, r2);
> > }
> > 
> > Other than that, this is fine.
> 
> Updated as suggested by Will, like this?

LGTM as well,

FWIW:
Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

thanks,

 - Joel

> 
> 							Thanx, Paul
> 
> ------------------------------------------------------------------------
> 
> commit adf43667b702582331d68acdf3732a6a017a182c
> Author: Alan Stern <stern@rowland.harvard.edu>
> Date:   Sun Oct 4 16:27:03 2020 -0700
> 
>     manual/kernel: Add a litmus test with a hidden dependency
>     
>     This commit adds a litmus test that has a data dependency that can be
>     hidden by control flow.  In this test, both the taken and the not-taken
>     branches of an "if" statement must be accounted for in order to properly
>     analyze the litmus test.  But herd7 looks only at individual executions
>     in isolation, so fails to see the dependency.
>     
>     Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
>     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> 
> diff --git a/manual/kernel/crypto-control-data.litmus b/manual/kernel/crypto-control-data.litmus
> new file mode 100644
> index 0000000..cdcdec9
> --- /dev/null
> +++ b/manual/kernel/crypto-control-data.litmus
> @@ -0,0 +1,34 @@
> +C crypto-control-data
> +(*
> + * LB plus crypto-control-data plus data
> + *
> + * Result: Sometimes
> + *
> + * This is an example of OOTA and we would like it to be forbidden.
> + * The WRITE_ONCE in P0 is both data-dependent and (at the hardware level)
> + * control-dependent on the preceding READ_ONCE.  But the dependencies are
> + * hidden by the form of the conditional control construct, hence the 
> + * name "crypto-control-data".  The memory model doesn't recognize them.
> + *)
> +
> +{}
> +
> +P0(int *x, int *y)
> +{
> +	int r1;
> +
> +	r1 = 1;
> +	if (READ_ONCE(*x) == 0)
> +		r1 = 0;
> +	WRITE_ONCE(*y, r1);
> +}
> +
> +P1(int *x, int *y)
> +{
> +	int r2;
> +
> +	r2 = READ_ONCE(*y);
> +	WRITE_ONCE(*x, r2);
> +}
> +
> +exists (0:r1=1)
