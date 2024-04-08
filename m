Return-Path: <linux-arch+bounces-3481-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E067989C91B
	for <lists+linux-arch@lfdr.de>; Mon,  8 Apr 2024 17:57:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 931C228348A
	for <lists+linux-arch@lfdr.de>; Mon,  8 Apr 2024 15:57:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F23A1420D5;
	Mon,  8 Apr 2024 15:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TrzSNofB"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEDF913E8AB;
	Mon,  8 Apr 2024 15:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712591875; cv=none; b=PQywnX5uztTVx9AI0iExlBcQNFRTCMK+tBcYC6yxbJ+sZq/y8aqC2igGy4QhuWL4q14iyuT4Mv15pnMP0ND4DLtu36TRDpTuoCK2JMyyPzW6Gh7L3MG/MmMBE0HPzmJgkycEXq1GxdT9sRRVbsnyXkFywPKwFCXJiSNkpZjh8SM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712591875; c=relaxed/simple;
	bh=untIyZUBolJmBC+haXZFudxoskemR2WDjgQpB/oOF7s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RAhNUrixkYqgxk2QY20ZvekhYMobftoLrmhVzYKVELwU+qDx7DRtdaUNPIhRTJZ4FZ+HgmypCMZjqT8vwKOYIgkT7THIh5MJFVtXcZQCFzrshdRGeQkDV24MEksvuAvaJZ0NWNokb+j6EzHRcCmdzSAGBCBz56FAAglruVA41to=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TrzSNofB; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2a2dd2221d3so2964693a91.0;
        Mon, 08 Apr 2024 08:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712591873; x=1713196673; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=untIyZUBolJmBC+haXZFudxoskemR2WDjgQpB/oOF7s=;
        b=TrzSNofB/+7iwz1qwxJ1kx0l5z5mdAWXGOBXrFX0/7cCpJd56VBWD77mwheGgmZXka
         x/bkuUA47B7QKpQNp27XN05H2RS7obfhlX6q79Uy7QOCbxxGBRnu/8dQgJPAaeBfHDij
         d9b7GrCih5KNDBgz8KQd09ZF66VWfxTDDLhR1QAFn7l2qA2yCJwJci9KMa21ysJAyonc
         0kK9/Q1Hzvrmsd/NNt+3ZrWR7dCvOsuGJERt6rMBWKbFJytsE5iSl2LQWF6Cy/puXDn5
         IGqpGy5FYYbmIdMlgclBw3TAuAalaLPliQTaKsN1jvtFJalCo1Uk29ywbrF95rph4zEa
         Ab8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712591873; x=1713196673;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=untIyZUBolJmBC+haXZFudxoskemR2WDjgQpB/oOF7s=;
        b=lVuarr2uS2MH6lsfPCn6zLOuWVoko2A3PPf5Zc69DJogpOnpHeLeDP5dO2qBBPN5ya
         11TXycCdMsVPXwofEXHKMsRq6ILjaiCDHp84/dShSk34KMSANBPS8JJ4Wof4m0HAlGSm
         wiebhAp8RAxADqV/PQSkNV0C0cSCVT940s+Azz2x4PdVPczGZa6lKzt2Ao4mW+GQgITZ
         HKKJAubI4TFOldsBt9Q3xHusQ6Cv+PDrvrpGUdAbqzIOCIyIvbKd0UXJYK4DtS3dOlcj
         CGISW2uckWR/2TPAgStAaLk2oI3fbjR75r37njFswkeGfiopgFVsAD/VF11TRcfcPRbH
         29YA==
X-Forwarded-Encrypted: i=1; AJvYcCWNso1C0Ns8zo1jhEyzhhtO74YZHqpNsZ/trlLewZmZwA8OAT6d7dgMFxa1YoQ99j3lexpRp+qwhVJntQx7q2/BhW4+m5fiATA/fTcFgfrKzUAvy4eWyk8DSr05BTwVXcO7FaZbwZkc4pyArUDvqRE23nM+UG0DqCyUsuVkEmOjb62mF6FgqZ44zG/rddngL+NHUWGpZvPaQXSwTK4KX53BfEDOxPMO2FRju/0Q+E4Sm/kNO8jz5OYlgRxCirRFtf5AxRpv0NPQY3K5c0vxJ13mTA/7I8ZDbDzXZ5Iy2Ll+Om8NwzHYlAuN8OmxF3IQ454PKvxs3daX21Imr0NoijRlDwIlJsUectnnMC97qrj5IZzQpQtPvUgA5/edslVDkxXGYEygawhsNWSr2i9USbDtzOOk5vEahcNx0+n6VS+0v2dkpPo/gbdO1kbBmyUE+gKssjdT0JOGXB1ZxfnAD1z+OhSN3tPTATeoRC+WtQ==
X-Gm-Message-State: AOJu0YyXWuQctnrMCEUojAFSK1BQfSW5IAp/oDstMbA8vc7dZ6DwaeB4
	FC+8NkTMNiO0moavdL5qhWZM8bBWyfRQVR52u1gFmrH+FmV3wcZ8
X-Google-Smtp-Source: AGHT+IGJbb2MaWRtYADIA840woW+fg7lVmIt69WB4JS2RPl12DQD69jPbBmSk/iEenJzneHNW7DHjg==
X-Received: by 2002:a17:90a:ab0d:b0:2a5:513:921e with SMTP id m13-20020a17090aab0d00b002a50513921emr2739861pjq.31.1712591873008;
        Mon, 08 Apr 2024 08:57:53 -0700 (PDT)
Received: from localhost ([2601:647:6881:9060:13a8:4fe8:4da1:7ea2])
        by smtp.gmail.com with ESMTPSA id z24-20020a17090ab11800b002a2559fe52esm6580894pjq.56.2024.04.08.08.57.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 08:57:52 -0700 (PDT)
Date: Mon, 8 Apr 2024 08:57:51 -0700
From: Cong Wang <xiyou.wangcong@gmail.com>
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-alpha@vger.kernel.org,
	linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
	sparclinux@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org, bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
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
	David Ahern <dsahern@kernel.org>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Shuah Khan <shuah@kernel.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Amritha Nambiar <amritha.nambiar@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Alexander Mikhalitsyn <alexander@mihalicyn.com>,
	Kaiyuan Zhang <kaiyuanz@google.com>,
	Christian Brauner <brauner@kernel.org>,
	Simon Horman <horms@kernel.org>,
	David Howells <dhowells@redhat.com>,
	Florian Westphal <fw@strlen.de>,
	Yunsheng Lin <linyunsheng@huawei.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>, Jens Axboe <axboe@kernel.dk>,
	Arseniy Krasnov <avkrasnov@salutedevices.com>,
	Aleksander Lobakin <aleksander.lobakin@intel.com>,
	Michael Lass <bevan@bi-co.net>, Jiri Pirko <jiri@resnulli.us>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Richard Gobert <richardbgobert@gmail.com>,
	Sridhar Samudrala <sridhar.samudrala@intel.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Abel Wu <wuyun.abel@bytedance.com>,
	Breno Leitao <leitao@debian.org>,
	Pavel Begunkov <asml.silence@gmail.com>, David Wei <dw@davidwei.uk>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Shailend Chand <shailend@google.com>,
	Harshitha Ramamurthy <hramamurthy@google.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Jeroen de Borst <jeroendb@google.com>,
	Praveen Kaligineedi <pkaligineedi@google.com>
Subject: Re: [RFC PATCH net-next v8 14/14] selftests: add ncdevmem, netcat
 for devmem TCP
Message-ID: <ZhQT/4RpKIkUmWut@pop-os.localdomain>
References: <20240403002053.2376017-1-almasrymina@google.com>
 <20240403002053.2376017-15-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240403002053.2376017-15-almasrymina@google.com>

On Tue, Apr 02, 2024 at 05:20:51PM -0700, Mina Almasry wrote:
> +static char *server_ip = "192.168.1.4";
> +static char *client_ip = "192.168.1.2";
> +static char *port = "5201";
> +static size_t do_validation;
> +static int start_queue = 8;
> +static int num_queues = 8;
> +static char *ifname = "eth1";
> +static unsigned int ifindex = 3;
> +static char *nic_pci_addr = "0000:06:00.0";

It seems this is set but never used.

Thanks.

