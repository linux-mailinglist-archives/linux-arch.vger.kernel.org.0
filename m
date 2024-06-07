Return-Path: <linux-arch+bounces-4750-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C65AD9007C1
	for <lists+linux-arch@lfdr.de>; Fri,  7 Jun 2024 16:57:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78A0A28BCDE
	for <lists+linux-arch@lfdr.de>; Fri,  7 Jun 2024 14:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7719519EEB1;
	Fri,  7 Jun 2024 14:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="hQJmj9FG"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D66519AA78
	for <linux-arch@vger.kernel.org>; Fri,  7 Jun 2024 14:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717771971; cv=none; b=NaMqON/L76ubpbwPfth7mabiKz5Zu0H0l0T+aohk6iGcK380NQ3fJlJWdnfhafIFZyuVUMQbbvI9REfKXE6FdD8C1l6NusTk6Vm3XXS8XCB7n9Nsr/QVJ1NYqdj16jOPC9cS1OGg5QwZV4hKYBjlA8MB6pcOXom68bPG6BmvGbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717771971; c=relaxed/simple;
	bh=lRtTAdTXNw3RVPrpvvNKKuuzE413bhtwKVpiQVvurek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p04ZY4oTzEJqeUiCbPKRS3C2Vi9U23hvxxtp5+uPHKI41qJpIQkODxtgcC0p9eUKNy6dxJWnAcfTuIO1yrBJ37s9m57vMVTFISmXQH1cRMkruZ8ltmxIket32nmcsIFaW2KQxDGfQegGu6zYGEuksuG8hI0H2kqLicWJaxEwwfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=hQJmj9FG; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7951713ba08so181038385a.1
        for <linux-arch@vger.kernel.org>; Fri, 07 Jun 2024 07:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1717771968; x=1718376768; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=be9t9+ReZ6YBtow20QbHH2FmkX+nC7rbtPeGa2mS4as=;
        b=hQJmj9FGqkDWyCgt/SU+4tUjCosWn1r7jPWCOxSoQcFLTAHBHmCt1UPHWUfacLPk0A
         J27M3PHiZT4a/3dgSP410VtO8nsNQzDfKUKFxJN3iIePAPaAXbaP+l6LyEKYF4CkTy48
         W7AEcymnLWnS3+i8chqAC7sLqibivCTcSwkpGR1xtaFDOarqDm2RsDk88kHT7kdlDC/+
         9Z8FIQqtXasRprzwCsdTxihilrlaHvGsr45MSTgHsNCW06TV4YSXg9RXEoJSh9JliJhN
         EElPiNvBU31l6J6yWS1+Pv/JSZLa707wvYnKwDocL0pue06OzOB0p871OIuyts6x8rd8
         zTsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717771968; x=1718376768;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=be9t9+ReZ6YBtow20QbHH2FmkX+nC7rbtPeGa2mS4as=;
        b=lRJpZRylWY9qF2fOtGR9eaF4XneDgQEvmOopXrt4Gkgho7IEDJosxeW+4FJSUaCco7
         pvj0tg04st4LD+0NIoa/rHmBQHuS1sGtfUZsh8KsjrPFlPB/eKcoHo52Pi233XmM2vkn
         2bOg28J+tLh7PtQwUs9gOAb4NsMYmfg97bLxWULCT8CfJaW8vb1lOq33o8CXEngWVhVx
         5jP+BcSbf+85IZQxwMdsmX/HVn5nrjQjIm1DtfJfZfR3gjIe97RROAfs+gj47FyaJTGi
         b/I2Qxd7TCudOvLv5FzXEuQGMWb2TqSwZdZtSLNAmlF14gjbnB/FkI6WNwmFIfi7RH4d
         Zgmg==
X-Forwarded-Encrypted: i=1; AJvYcCUpfQgHV2tJ2Vu4FQars97xmRY7NIfZl0NihAkhaGnIWeEeoWpGQTF6iDsXzgRgoYHNBraUpxA9iKrIxy7DgwO/6mUsQuq+PpM4dQ==
X-Gm-Message-State: AOJu0YyUzhQgnrN0L6ixpWb4bS5RGOS9NaeqUwdbKOEtYV17DaNDzEnf
	51CUcAFAgAn0WbaCwU6JYijFWNG2Y1v91+HuHYEXBxi/LWelIN7xebEY44O5vUw=
X-Google-Smtp-Source: AGHT+IEol1YR1WI0zC3A5eIuWJjKcIm2ZGRprGfgrv26PYx2gMqkRphUST2lY2DmLHNeG4xW82MRzw==
X-Received: by 2002:a05:620a:31a8:b0:795:4e67:1ef5 with SMTP id af79cd13be357-7954e672231mr106304685a.11.1717771968557;
        Fri, 07 Jun 2024 07:52:48 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79532870231sm173090885a.60.2024.06.07.07.52.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 07:52:48 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sFaxT-00HGBa-Cf;
	Fri, 07 Jun 2024 11:52:47 -0300
Date: Fri, 7 Jun 2024 11:52:47 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: David Ahern <dsahern@kernel.org>
Cc: Pavel Begunkov <asml.silence@gmail.com>,
	Mina Almasry <almasrymina@google.com>,
	Christoph Hellwig <hch@infradead.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-alpha@vger.kernel.org, linux-mips@vger.kernel.org,
	linux-parisc@vger.kernel.org, sparclinux@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Richard Henderson <richard.henderson@linaro.org>,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	Matt Turner <mattst88@gmail.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	Helge Deller <deller@gmx.de>, Andreas Larsson <andreas@gaisler.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Arnd Bergmann <arnd@arndb.de>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Shuah Khan <shuah@kernel.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
	David Wei <dw@davidwei.uk>, Yunsheng Lin <linyunsheng@huawei.com>,
	Shailend Chand <shailend@google.com>,
	Harshitha Ramamurthy <hramamurthy@google.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Jeroen de Borst <jeroendb@google.com>,
	Praveen Kaligineedi <pkaligineedi@google.com>
Subject: Re: [PATCH net-next v10 02/14] net: page_pool: create hooks for
 custom page providers
Message-ID: <20240607145247.GG791043@ziepe.ca>
References: <20240530201616.1316526-1-almasrymina@google.com>
 <20240530201616.1316526-3-almasrymina@google.com>
 <ZlqzER_ufrhlB28v@infradead.org>
 <CAHS8izMU_nMEr04J9kXiX6rJqK4nQKA+W-enKLhNxvK7=H2pgA@mail.gmail.com>
 <5aee4bba-ca65-443c-bd78-e5599b814a13@gmail.com>
 <CAHS8izNmT_NzgCu1pY1RKgJh+kP2rCL_90Gqau2Pkd3-48Q1_w@mail.gmail.com>
 <eb237e6e-3626-4435-8af5-11ed3931b0ac@gmail.com>
 <be2d140f-db0f-4d15-967c-972ea6586b5c@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <be2d140f-db0f-4d15-967c-972ea6586b5c@kernel.org>

On Fri, Jun 07, 2024 at 08:27:29AM -0600, David Ahern wrote:
> On 6/7/24 7:42 AM, Pavel Begunkov wrote:
> > I haven't seen any arguments against from the (net) maintainers so
> > far. Nor I see any objection against callbacks from them (considering
> > that either option adds an if).
> 
> I have said before I do not understand why the dmabuf paradigm is not
> sufficient for both device memory and host memory. A less than ideal
> control path to put hostmem in a dmabuf wrapper vs extra checks and
> changes in the datapath. The former should always be preferred.

I think Pavel explained this - his project is principally to replace
the lifetime policy of pages in the data plane. He wants to change
when a page is considered available for re-allocation because
userspace may continue to use the page after the netstack thinks it is
done with it. It sounds like having a different source of the pages is
the less important part.

IMHO it seems to compose poorly if you can only use the io_uring
lifecycle model with io_uring registered memory, and not with DMABUF
memory registered through Mina's mechanism.

Jason

