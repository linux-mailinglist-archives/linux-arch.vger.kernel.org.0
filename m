Return-Path: <linux-arch+bounces-12598-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BF689AFE292
	for <lists+linux-arch@lfdr.de>; Wed,  9 Jul 2025 10:29:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47A41189732E
	for <lists+linux-arch@lfdr.de>; Wed,  9 Jul 2025 08:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AD4F273D9D;
	Wed,  9 Jul 2025 08:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cKk0/Pov"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D298D2741BC;
	Wed,  9 Jul 2025 08:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752049760; cv=none; b=T+Kx3p8iEaDUpfopV7sH6NpAx1bVxbmOE3tcU9Fq47az9K9NBXGr6WxXxi229I+PxxIL7p4qWBxxYQIg7Hyg1dPJMYGZDK7Z1cLhT7/a1ep1jHdyzkKSSv2z1WK/rid+y1zraTJOAPPZgWaMw+xkdI9sCIbQ9F2XhJQpNSzMsQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752049760; c=relaxed/simple;
	bh=haNODZWMyCOVGzhyyomPE8OSX9fncV1D0JZRv1zBfWw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kSnT1O1GJYOx1HmNC9jJYK16ol8320NkGwVGj4c6VYb8Y88/eWp2Tq6dyDXaTTwluprDuxJsvvmJrKXIkEQ5P7oZMulawGI2AILlt9IltWwd3l+sMxiQ71ecVR7vLxqBlSvE1ki4W+HgxpQcKzlFIIOcN4ZeC4AtXl+2hmIwykk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cKk0/Pov; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5237C4CEEF;
	Wed,  9 Jul 2025 08:29:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752049760;
	bh=haNODZWMyCOVGzhyyomPE8OSX9fncV1D0JZRv1zBfWw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cKk0/PovFNWjoitwee81tCcXv3dX38aYYI6XsZYqFMyiabERzUy8nWpJxMhvr7TOp
	 CSbWP5fsjKIwQ6NJxx+ZEx3WyGH7mUO3PKrwaOAcvdlqSDYRw7gs2Y7ztiEFImVBCX
	 iTUF7V8lPomDSu42VlLdxCkaLSjLSmfOSVb4WQvB4msxx+Wy25zWuIlBXSMaf3ov4/
	 XEJNJxyG1uLCGnXB3DME1TqOZZLuLG8NmetXAqxMIDW0+HcZMCr3Y+GBXecatwJ1Pe
	 FGX+j0TfuXirzE0/lzqfR4n7fkldxqwd49qx6/4nhmf6J127srosUJEunRbi6l82Yh
	 19rQl2a1iKfmw==
Date: Wed, 9 Jul 2025 09:29:17 +0100
From: Mark Brown <broonie@kernel.org>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>
Cc: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Shuah Khan <shuah@kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
	Richard Cochran <richardcochran@gmail.com>,
	Christopher Hall <christopher.s.hall@intel.com>,
	Miroslav Lichvar <mlichvar@redhat.com>,
	Werner Abt <werner.abt@meinberg-usa.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Kurt Kanzenbach <kurt@linutronix.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Nam Cao <namcao@linutronix.de>, Antoine Tenart <atenart@kernel.org>
Subject: Re: [PATCH 06/14] vdso/gettimeofday: Return bool from
 clock_gettime() helpers
Message-ID: <aG4oXcA3U8qa3H86@finisterre.sirena.org.uk>
References: <20250701-vdso-auxclock-v1-0-df7d9f87b9b8@linutronix.de>
 <20250701-vdso-auxclock-v1-6-df7d9f87b9b8@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="8p2AxLcgYrx+Az4a"
Content-Disposition: inline
In-Reply-To: <20250701-vdso-auxclock-v1-6-df7d9f87b9b8@linutronix.de>
X-Cookie: Absence makes the heart go wander.


--8p2AxLcgYrx+Az4a
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 01, 2025 at 10:58:00AM +0200, Thomas Wei=DFschuh wrote:
> The internal helpers are effectively using boolean results,
> while pretending to use error numbers.
>=20
> Switch the return type to bool for more clarity.

Marek already reported and analysed a hwclock issue with this but I'm
also seeing issues with the vDSO selftest's vdso_test_correcteness on
pine64plus (an arm64 board) which bisect down to this patch:

# [RUN]	Testing gettimeofday...
# 	1752000653.829103 0.000000 1752000653.829106
# [FAIL]	Times are out of sequence

   https://lava.sirena.org.uk/scheduler/job/1550140#L9170

and it causes infrastructure issues due to time on x15 (a 32 bit arm
platform):

| INFO: Generating a skipfile based on /lava-4163764/1/tests/5_kselftest-si=
gnal/automated/linux/kselftest/skipfile-lkft.yaml
| fatal error: nanotime returning zero
| goroutine 1 [running, locked to thread]:
| runtime.throw(0x132d83, 0x17)
| 	/usr/lib/golang/src/runtime/panic.go:774 +0x5c fp=3D0x42c7a4 sp=3D0x42c7=
90 pc=3D0x3b740
| runtime.main()
|	/usr/lib/golang/src/runtime/proc.go:152 +0x350 fp=3D0x42c7e4 sp=3D0x42c7a=
4 pc=3D0x3d308
| runtime.goexit()
|	/usr/lib/golang/src/runtime/asm_arm.s:868 +0x4 fp=3D0x42c7e4 sp=3D0x42c7e=
4 pc=3D0x645dc
| ERROR: skipgen failed to generate a skipfile: 2

   https://validation.linaro.org/scheduler/job/4163764#L2162

for mystifying reasons which bisect similarly.  I'll try to test Marek's
fix but I'm at a conference this week so no guarantees.

bisect for pine64plus:

# bad: [58ba80c4740212c29a1cf9b48f588e60a7612209] Add linux-next specific f=
iles for 20250708
# good: [3a92879a3786d4f28bb3a91a07fd58359b29ca13] Merge branch 'for-linux-=
next-fixes' of https://gitlab.freedesktop.org/drm/misc/kernel.git
# good: [08dc0f5cc26a203e8008c38d9b436c079e7dbb45] ASoC: soc-dapm: add pref=
ix on soc_dapm_dev_attrs
# good: [571defe0dff3f1e4180bd0db79283d3d5bf74a71] ASoC: codec: rockchip_sa=
i: Remove including of_gpio.h
# good: [2fca750160f29015ab1109bb478537a4e415f7cd] spi: Remove redundant pm=
_runtime_mark_last_busy() calls
# good: [2bd9648d5a8d329ca734ca2c273a80934867471e] ASoC: SOF: Remove redund=
ant pm_runtime_mark_last_busy() calls
# good: [c61e94e5e4e6bc50064119e6a779564d1d2ac0e7] regulator: stm32-vrefbuf=
: Remove redundant pm_runtime_mark_last_busy() calls
# good: [bc163baef57002c08b3afe64cdd2f55f55a765eb] ASoC: Use of_reserved_me=
m_region_to_resource() for "memory-region"
# good: [9f711c9321cffe3e03709176873c277fa911c366] regmap: get rid of redun=
dant debugfs_file_{get,put}()
# good: [baee26a9d6cd3d3c6c3c03c56270aa647a67e4bd] ASoC: fsl_mqs: rename sy=
stem manager indices for i.MX95
# good: [7105fdd54a14bee49371b39374a61b3c967d74cb] spi: dt-bindings: Conver=
t marvell,orion-spi to DT schema
# good: [913bf8d50cbd144c87e9660b591781179182ff59] spi: spi-qpic-snand: add=
 support for 8 bits ECC strength
# good: [34d340d48e595f8dfd4e72fe4100d2579dbe4a1a] ASoC: qcom: sc8280xp: Ad=
d support for QCS8275
# good: [0c0ef1d90967717b91cded41b00dbae05d8e521c] ASoC: amd: acp: Enable a=
cp7.2 platform based DMIC support in machine driver
# good: [3fcd3d2fe44dc9dfca20b6aed117f314a50ba0ff] spi: offload trigger: ad=
d ADI Util Sigma-Delta SPI driver
# good: [244bc18e5f1875401a4af87d2eae3f9376d9d720] spi: stm32: delete stray=
 tabs in stm32h7_spi_data_idleness()
# good: [7e1c28fbf235791cb5046fafdac5bc16fe8e788d] spi: spi-pci1xxxx: enabl=
e concurrent DMA read/write across SPI transfers
# good: [c4f2c05ab02952c9a56067aeb700ded95b183570] spi: stm32: fix pointer-=
to-pointer variables usage
# good: [b9ab3b61824190b1c6b2c59e7ba4de591f24eb92] ASoC: SDCA: Add some ini=
tial IRQ handlers
# good: [427ceac823e58813b510e585011488f603f0d891] regulator: tps6286x-regu=
lator: Enable REGCACHE_MAPLE
# good: [29ddce17e909779633f856ad1c2f111fbf71c0df] ASoC: codecs: Add calibr=
ation function to aw88399 chip
# good: [ac4c064f67d3cdf9118b9b09c1e3b28b6c10a7ea] spi: dt-bindings: add nx=
p,lpc3220-spi.yaml
# good: [08bf1663c21a3e815eda28fa242d84c945ca3b94] dmaengine: Add devm_dma_=
request_chan()
# good: [ce57bc9771411d6d27f2ca7b40396cbd7d684ba9] regulator: core: Don't u=
se "proxy" headers
# good: [2555691165a0285a4617230fed859f20dcc51608] spi: atmel-quadspi: Use =
`devm_dma_request_chan()`
# good: [0f60ecffbfe35e12eb56c99640ba2360244b5bb3] ASoC: sdw_utils: generat=
e combined spk components string
# good: [9a944494c299fabf3cc781798eb7c02a0bece364] spi: dt-bindings: stm32:=
 deprecate `st,spi-midi-ns` property
# good: [3e36c822506d924894ff7de549b9377d3114c2d7] spi: spi-pci1xxxx: Add s=
upport for per-instance DMA interrupt vectors
# good: [68fbc70ece40139380380dce74059afa592846b3] ASoC: hisilicon: Standar=
dize ASoC menu
# good: [8f9cf02c8852837923f1cdacfcc92e138513325c] spi: microchip-core-qspi=
: Add regular transfers
# good: [17cc308b183308bf5ada36e164284fff7eb064ba] ASoC: wm8524: enable con=
straints when sysclk is configured.
# good: [59566923d955b69bfb1e1163f07dff437dde8c9c] ASoC: SOF: amd: add alte=
rnate machines for ACP7.0 and ACP7.1 platforms
# good: [024f39fff6d222cedde361f7fe34d9ba4e6afb92] regulator: mtk-dvfsrc: A=
dd support for MediaTek MT8196 DVFSRC
# good: [19cbc930c209d59a2c9828de4c7b767e9f14667e] regulator: pca9450: Supp=
ort PWM mode also for pca9451a
# good: [c4ca928a6db1593802cd945f075a7e21dd0430c1] ASoC: hdac_hdmi: Rate li=
mit logging on connection and disconnection
# good: [a48352921f0b15b1f7eff83f5b5613d6ae2350d3] ASoC: codecs: wcd939x: A=
dd defines for major/minor version decoding
# good: [3421d46440ebe0865bec71dbd2330b4e17a425ab] HID: core: Add bus defin=
e for SoundWire bus
# good: [a1d203d390e04798ccc1c3c06019cd4411885d6d] ASoC: SOF: ipc4-pcm: Ena=
ble delay reporting for ChainDMA streams
# good: [bb48117b79ebc39485f7306d09dc602981fe540f] ASoC: Intel: sof_sdw: Im=
plement add_dai_link to filter HDMI PCMs
# good: [ace9b3daf2b4778358573d3698e34cb1c0fa7e14] ASoC: SOF: ipc4/Intel: A=
dd support for library restore firmware functionality
# good: [2756b7f08ff6ca7c68c8c7dd61c8dc6895c9de34] ASoC: SOF: ipc4-pcm: Har=
monize sof_ipc4_set_pipeline_state() dbg print
# good: [5fc2c383125c2b4b6037e02ad8796b776b25e6d0] spi: falcon: mark falcon=
_sflash_xfer() as static
# good: [cd4da713f99651e99fbce8ed6b6ec8f686c029a8] Documentation: PM: *_aut=
osuspend() functions update last busy time
# good: [7f8924e8785b68c998bc1906e049bf5595865e60] ASoC: dt-bindings: cirru=
s,cs42xx8: add 'port' property
# good: [3e1c01d06e1f52f78fe00ef26a9cf80dbb0a3115] regulator: rpi-panel-v2:=
 Add shutdown hook
# good: [d9f38d9824bfb1b046d2e720349d2f45959ab184] ASoC: tegra: AHUB: Remov=
e unneeded semicolon
# good: [dce4bc30f42d313b4dc5832316196411b7f07ad0] spi: spi-fsl-dspi: Rever=
t unintended dependency change in config SPI_FSL_DSPI
# good: [47972c1c3315672352f25c68f91dd88543541947] ASoC: Intel: Replace dep=
recated strcpy() with strscpy()
# good: [5eb8a0d7733d4cd32a776acf1d1aa1c7c01c8a14] ASoC: hdmi-codec: use SN=
D_JACK_AVOUT as jack status
# good: [bb8d8ba4715cb8f997d63d90ba935f6073595df5] ASoC: mediatek: mt8183-a=
fe-pcm: use local `dev` pointer in driver callbacks
# good: [8a5a5cecb79058b608e5562d8998123a3adb313c] ASoC: tas2781: Move the =
"include linux/debugfs.h" into tas2781.h
# good: [a4eb71ff98c4792f441f108910bd829da7a04092] regulator: rpi-panel-v2:=
 Fix missing OF dependency
# good: [6cafcc53eb5fffd9b9bdfde700bb9bad21e98ed3] spi: spi-mt65xx: Add sup=
port for MT6991 Dimensity 9400 SPI IPM
# good: [7e10d7242ea8a5947878880b912ffa5806520705] ASoC: ops: dynamically a=
llocate struct snd_ctl_elem_value
# good: [d6fa0ca959db8efd4462d7beef4bdc5568640fd0] regulator: rpi-panel-v2:=
 Add missing GPIOLIB dependency
# good: [6ba68e5aa9d5d15c8877a655db279fcfc0b38b04] ASoC: renesas: msiof: Co=
nvert to <linux/spi/sh_msiof.h>
# good: [1f5cdb6ab45e1c06ae0953609acbb52f8946b3e8] ASoC: codecs: Add suppor=
t for Richtek RTQ9124
# good: [d49305862fdc4d9ff1b1093b4ed7d8e0cb9971b4] regulator: rpi-panel-v2:=
 Add regulator for 7" Raspberry Pi 720x1280
# good: [03b778d1994827ea5cc971dbdfbb457bbb7bfa5d] ASOC: rockchip: Use help=
er function devm_clk_get_enabled()
# good: [c459262159f39e6e6336797feb975799344b749b] spi: spi-pci1xxxx: Add s=
upport for 25MHz Clock frequency in C0
# good: [267be32b0a7b70cc777f8a46f0904c92c0521d89] ASoC: remove component->=
id
# good: [548d770c330cd1027549947a6ea899c56b5bc4e4] regulator: pca9450: Add =
support for mode operations
# good: [111a2c8ab462d77d1519b71b46f13ae1b46920b4] ASoC: imx-card: Use help=
er function for_each_child_of_node_scoped()
# good: [f6f914893d478b7ba08e5c375de1ced16deb5e92] ASoC: dt-bindings: tas57=
xx: add tas5753 compatibility
# good: [9a30e332c36c52e92e5316b4a012d45284dedeb5] spi: spi-fsl-dspi: Enabl=
e support for S32G platforms
# good: [c95e925daa434ee1a40a86aec6476ce588e4bd77] ASoC: Intel: avs: Add rt=
5640 machine board
# good: [ac209bde018fd320b79976657a44c23113181af6] ASoC: tas2781: Drop the =
unnecessary symbol imply
# good: [ece5d881004f041c2e1493436409dbcbea3ad5f8] ASoC: codecs: wcd939x: D=
rop unused 'struct wcd939x_priv' fields
# good: [b9ecde0bcf6a99a3ff08496d4ba90a385ebbfd68] ASoC: codecs: wcd939x: A=
dd VDD_PX supply
# good: [c8c4694ede7ed42d8d4db0e8927dea9839a3e248] regmap: kunit: Constify =
regmap_range_cfg array
# good: [e6e8897995a9e6028563ce36c27877e5478c8571] ASoC: qcom: sm8250: Add =
Fairphone 5 soundcard compatible
git bisect start '58ba80c4740212c29a1cf9b48f588e60a7612209' '3a92879a3786d4=
f28bb3a91a07fd58359b29ca13' '08dc0f5cc26a203e8008c38d9b436c079e7dbb45' '571=
defe0dff3f1e4180bd0db79283d3d5bf74a71' '2fca750160f29015ab1109bb478537a4e41=
5f7cd' '2bd9648d5a8d329ca734ca2c273a80934867471e' 'c61e94e5e4e6bc50064119e6=
a779564d1d2ac0e7' 'bc163baef57002c08b3afe64cdd2f55f55a765eb' '9f711c9321cff=
e3e03709176873c277fa911c366' 'baee26a9d6cd3d3c6c3c03c56270aa647a67e4bd' '71=
05fdd54a14bee49371b39374a61b3c967d74cb' '913bf8d50cbd144c87e9660b5917811791=
82ff59' '34d340d48e595f8dfd4e72fe4100d2579dbe4a1a' '0c0ef1d90967717b91cded4=
1b00dbae05d8e521c' '3fcd3d2fe44dc9dfca20b6aed117f314a50ba0ff' '244bc18e5f18=
75401a4af87d2eae3f9376d9d720' '7e1c28fbf235791cb5046fafdac5bc16fe8e788d' 'c=
4f2c05ab02952c9a56067aeb700ded95b183570' 'b9ab3b61824190b1c6b2c59e7ba4de591=
f24eb92' '427ceac823e58813b510e585011488f603f0d891' '29ddce17e909779633f856=
ad1c2f111fbf71c0df' 'ac4c064f67d3cdf9118b9b09c1e3b28b6c10a7ea' '08bf1663c21=
a3e815eda28fa242d84c945ca3b94' 'ce57bc9771411d6d27f2ca7b40396cbd7d684ba9' '=
2555691165a0285a4617230fed859f20dcc51608' '0f60ecffbfe35e12eb56c99640ba2360=
244b5bb3' '9a944494c299fabf3cc781798eb7c02a0bece364' '3e36c822506d924894ff7=
de549b9377d3114c2d7' '68fbc70ece40139380380dce74059afa592846b3' '8f9cf02c88=
52837923f1cdacfcc92e138513325c' '17cc308b183308bf5ada36e164284fff7eb064ba' =
'59566923d955b69bfb1e1163f07dff437dde8c9c' '024f39fff6d222cedde361f7fe34d9b=
a4e6afb92' '19cbc930c209d59a2c9828de4c7b767e9f14667e' 'c4ca928a6db1593802cd=
945f075a7e21dd0430c1' 'a48352921f0b15b1f7eff83f5b5613d6ae2350d3' '3421d4644=
0ebe0865bec71dbd2330b4e17a425ab' 'a1d203d390e04798ccc1c3c06019cd4411885d6d'=
 'bb48117b79ebc39485f7306d09dc602981fe540f' 'ace9b3daf2b4778358573d3698e34c=
b1c0fa7e14' '2756b7f08ff6ca7c68c8c7dd61c8dc6895c9de34' '5fc2c383125c2b4b603=
7e02ad8796b776b25e6d0' 'cd4da713f99651e99fbce8ed6b6ec8f686c029a8' '7f8924e8=
785b68c998bc1906e049bf5595865e60' '3e1c01d06e1f52f78fe00ef26a9cf80dbb0a3115=
' 'd9f38d9824bfb1b046d2e720349d2f45959ab184' 'dce4bc30f42d313b4dc5832316196=
411b7f07ad0' '47972c1c3315672352f25c68f91dd88543541947' '5eb8a0d7733d4cd32a=
776acf1d1aa1c7c01c8a14' 'bb8d8ba4715cb8f997d63d90ba935f6073595df5' '8a5a5ce=
cb79058b608e5562d8998123a3adb313c' 'a4eb71ff98c4792f441f108910bd829da7a0409=
2' '6cafcc53eb5fffd9b9bdfde700bb9bad21e98ed3' '7e10d7242ea8a5947878880b912f=
fa5806520705' 'd6fa0ca959db8efd4462d7beef4bdc5568640fd0' '6ba68e5aa9d5d15c8=
877a655db279fcfc0b38b04' '1f5cdb6ab45e1c06ae0953609acbb52f8946b3e8' 'd49305=
862fdc4d9ff1b1093b4ed7d8e0cb9971b4' '03b778d1994827ea5cc971dbdfbb457bbb7bfa=
5d' 'c459262159f39e6e6336797feb975799344b749b' '267be32b0a7b70cc777f8a46f09=
04c92c0521d89' '548d770c330cd1027549947a6ea899c56b5bc4e4' '111a2c8ab462d77d=
1519b71b46f13ae1b46920b4' 'f6f914893d478b7ba08e5c375de1ced16deb5e92' '9a30e=
332c36c52e92e5316b4a012d45284dedeb5' 'c95e925daa434ee1a40a86aec6476ce588e4b=
d77' 'ac209bde018fd320b79976657a44c23113181af6' 'ece5d881004f041c2e14934364=
09dbcbea3ad5f8' 'b9ecde0bcf6a99a3ff08496d4ba90a385ebbfd68' 'c8c4694ede7ed42=
d8d4db0e8927dea9839a3e248' 'e6e8897995a9e6028563ce36c27877e5478c8571'
# test job: [08dc0f5cc26a203e8008c38d9b436c079e7dbb45] https://lava.sirena.=
org.uk/scheduler/job/1546279
# test job: [571defe0dff3f1e4180bd0db79283d3d5bf74a71] https://lava.sirena.=
org.uk/scheduler/job/1539758
# test job: [2fca750160f29015ab1109bb478537a4e415f7cd] https://lava.sirena.=
org.uk/scheduler/job/1540294
# test job: [2bd9648d5a8d329ca734ca2c273a80934867471e] https://lava.sirena.=
org.uk/scheduler/job/1539587
# test job: [c61e94e5e4e6bc50064119e6a779564d1d2ac0e7] https://lava.sirena.=
org.uk/scheduler/job/1538605
# test job: [bc163baef57002c08b3afe64cdd2f55f55a765eb] https://lava.sirena.=
org.uk/scheduler/job/1538760
# test job: [9f711c9321cffe3e03709176873c277fa911c366] https://lava.sirena.=
org.uk/scheduler/job/1538695
# test job: [baee26a9d6cd3d3c6c3c03c56270aa647a67e4bd] https://lava.sirena.=
org.uk/scheduler/job/1533838
# test job: [7105fdd54a14bee49371b39374a61b3c967d74cb] https://lava.sirena.=
org.uk/scheduler/job/1533505
# test job: [913bf8d50cbd144c87e9660b591781179182ff59] https://lava.sirena.=
org.uk/scheduler/job/1531279
# test job: [34d340d48e595f8dfd4e72fe4100d2579dbe4a1a] https://lava.sirena.=
org.uk/scheduler/job/1530316
# test job: [0c0ef1d90967717b91cded41b00dbae05d8e521c] https://lava.sirena.=
org.uk/scheduler/job/1530377
# test job: [3fcd3d2fe44dc9dfca20b6aed117f314a50ba0ff] https://lava.sirena.=
org.uk/scheduler/job/1528995
# test job: [244bc18e5f1875401a4af87d2eae3f9376d9d720] https://lava.sirena.=
org.uk/scheduler/job/1528294
# test job: [7e1c28fbf235791cb5046fafdac5bc16fe8e788d] https://lava.sirena.=
org.uk/scheduler/job/1525609
# test job: [c4f2c05ab02952c9a56067aeb700ded95b183570] https://lava.sirena.=
org.uk/scheduler/job/1526240
# test job: [b9ab3b61824190b1c6b2c59e7ba4de591f24eb92] https://lava.sirena.=
org.uk/scheduler/job/1526368
# test job: [427ceac823e58813b510e585011488f603f0d891] https://lava.sirena.=
org.uk/scheduler/job/1525674
# test job: [29ddce17e909779633f856ad1c2f111fbf71c0df] https://lava.sirena.=
org.uk/scheduler/job/1523960
# test job: [ac4c064f67d3cdf9118b9b09c1e3b28b6c10a7ea] https://lava.sirena.=
org.uk/scheduler/job/1515936
# test job: [08bf1663c21a3e815eda28fa242d84c945ca3b94] https://lava.sirena.=
org.uk/scheduler/job/1517680
# test job: [ce57bc9771411d6d27f2ca7b40396cbd7d684ba9] https://lava.sirena.=
org.uk/scheduler/job/1515829
# test job: [2555691165a0285a4617230fed859f20dcc51608] https://lava.sirena.=
org.uk/scheduler/job/1515774
# test job: [0f60ecffbfe35e12eb56c99640ba2360244b5bb3] https://lava.sirena.=
org.uk/scheduler/job/1511599
# test job: [9a944494c299fabf3cc781798eb7c02a0bece364] https://lava.sirena.=
org.uk/scheduler/job/1507913
# test job: [3e36c822506d924894ff7de549b9377d3114c2d7] https://lava.sirena.=
org.uk/scheduler/job/1506345
# test job: [68fbc70ece40139380380dce74059afa592846b3] https://lava.sirena.=
org.uk/scheduler/job/1504169
# test job: [8f9cf02c8852837923f1cdacfcc92e138513325c] https://lava.sirena.=
org.uk/scheduler/job/1502871
# test job: [17cc308b183308bf5ada36e164284fff7eb064ba] https://lava.sirena.=
org.uk/scheduler/job/1501545
# test job: [59566923d955b69bfb1e1163f07dff437dde8c9c] https://lava.sirena.=
org.uk/scheduler/job/1499651
# test job: [024f39fff6d222cedde361f7fe34d9ba4e6afb92] https://lava.sirena.=
org.uk/scheduler/job/1499702
# test job: [19cbc930c209d59a2c9828de4c7b767e9f14667e] https://lava.sirena.=
org.uk/scheduler/job/1497288
# test job: [c4ca928a6db1593802cd945f075a7e21dd0430c1] https://lava.sirena.=
org.uk/scheduler/job/1496256
# test job: [a48352921f0b15b1f7eff83f5b5613d6ae2350d3] https://lava.sirena.=
org.uk/scheduler/job/1497361
# test job: [3421d46440ebe0865bec71dbd2330b4e17a425ab] https://lava.sirena.=
org.uk/scheduler/job/1493081
# test job: [a1d203d390e04798ccc1c3c06019cd4411885d6d] https://lava.sirena.=
org.uk/scheduler/job/1491513
# test job: [bb48117b79ebc39485f7306d09dc602981fe540f] https://lava.sirena.=
org.uk/scheduler/job/1489350
# test job: [ace9b3daf2b4778358573d3698e34cb1c0fa7e14] https://lava.sirena.=
org.uk/scheduler/job/1489286
# test job: [2756b7f08ff6ca7c68c8c7dd61c8dc6895c9de34] https://lava.sirena.=
org.uk/scheduler/job/1489210
# test job: [5fc2c383125c2b4b6037e02ad8796b776b25e6d0] https://lava.sirena.=
org.uk/scheduler/job/1486896
# test job: [cd4da713f99651e99fbce8ed6b6ec8f686c029a8] https://lava.sirena.=
org.uk/scheduler/job/1538863
# test job: [7f8924e8785b68c998bc1906e049bf5595865e60] https://lava.sirena.=
org.uk/scheduler/job/1486908
# test job: [3e1c01d06e1f52f78fe00ef26a9cf80dbb0a3115] https://lava.sirena.=
org.uk/scheduler/job/1481717
# test job: [d9f38d9824bfb1b046d2e720349d2f45959ab184] https://lava.sirena.=
org.uk/scheduler/job/1481619
# test job: [dce4bc30f42d313b4dc5832316196411b7f07ad0] https://lava.sirena.=
org.uk/scheduler/job/1479449
# test job: [47972c1c3315672352f25c68f91dd88543541947] https://lava.sirena.=
org.uk/scheduler/job/1479571
# test job: [5eb8a0d7733d4cd32a776acf1d1aa1c7c01c8a14] https://lava.sirena.=
org.uk/scheduler/job/1474490
# test job: [bb8d8ba4715cb8f997d63d90ba935f6073595df5] https://lava.sirena.=
org.uk/scheduler/job/1472035
# test job: [8a5a5cecb79058b608e5562d8998123a3adb313c] https://lava.sirena.=
org.uk/scheduler/job/1471848
# test job: [a4eb71ff98c4792f441f108910bd829da7a04092] https://lava.sirena.=
org.uk/scheduler/job/1468995
# test job: [6cafcc53eb5fffd9b9bdfde700bb9bad21e98ed3] https://lava.sirena.=
org.uk/scheduler/job/1468942
# test job: [7e10d7242ea8a5947878880b912ffa5806520705] https://lava.sirena.=
org.uk/scheduler/job/1466042
# test job: [d6fa0ca959db8efd4462d7beef4bdc5568640fd0] https://lava.sirena.=
org.uk/scheduler/job/1464679
# test job: [6ba68e5aa9d5d15c8877a655db279fcfc0b38b04] https://lava.sirena.=
org.uk/scheduler/job/1463330
# test job: [1f5cdb6ab45e1c06ae0953609acbb52f8946b3e8] https://lava.sirena.=
org.uk/scheduler/job/1462967
# test job: [d49305862fdc4d9ff1b1093b4ed7d8e0cb9971b4] https://lava.sirena.=
org.uk/scheduler/job/1463039
# test job: [03b778d1994827ea5cc971dbdfbb457bbb7bfa5d] https://lava.sirena.=
org.uk/scheduler/job/1461893
# test job: [c459262159f39e6e6336797feb975799344b749b] https://lava.sirena.=
org.uk/scheduler/job/1461009
# test job: [267be32b0a7b70cc777f8a46f0904c92c0521d89] https://lava.sirena.=
org.uk/scheduler/job/1460419
# test job: [548d770c330cd1027549947a6ea899c56b5bc4e4] https://lava.sirena.=
org.uk/scheduler/job/1460085
# test job: [111a2c8ab462d77d1519b71b46f13ae1b46920b4] https://lava.sirena.=
org.uk/scheduler/job/1460877
# test job: [f6f914893d478b7ba08e5c375de1ced16deb5e92] https://lava.sirena.=
org.uk/scheduler/job/1461476
# test job: [9a30e332c36c52e92e5316b4a012d45284dedeb5] https://lava.sirena.=
org.uk/scheduler/job/1460560
# test job: [c95e925daa434ee1a40a86aec6476ce588e4bd77] https://lava.sirena.=
org.uk/scheduler/job/1460134
# test job: [ac209bde018fd320b79976657a44c23113181af6] https://lava.sirena.=
org.uk/scheduler/job/1461916
# test job: [ece5d881004f041c2e1493436409dbcbea3ad5f8] https://lava.sirena.=
org.uk/scheduler/job/1461683
# test job: [b9ecde0bcf6a99a3ff08496d4ba90a385ebbfd68] https://lava.sirena.=
org.uk/scheduler/job/1461078
# test job: [c8c4694ede7ed42d8d4db0e8927dea9839a3e248] https://lava.sirena.=
org.uk/scheduler/job/1461314
# test job: [e6e8897995a9e6028563ce36c27877e5478c8571] https://lava.sirena.=
org.uk/scheduler/job/1461772
# test job: [58ba80c4740212c29a1cf9b48f588e60a7612209] https://lava.sirena.=
org.uk/scheduler/job/1548198
# bad: [58ba80c4740212c29a1cf9b48f588e60a7612209] Add linux-next specific f=
iles for 20250708
git bisect bad 58ba80c4740212c29a1cf9b48f588e60a7612209
# test job: [ddadac3880bcacd8ae5ef9c8a975ab0f29365279] https://lava.sirena.=
org.uk/scheduler/job/1548466
# good: [ddadac3880bcacd8ae5ef9c8a975ab0f29365279] Merge branch 'for-next' =
of git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git
git bisect good ddadac3880bcacd8ae5ef9c8a975ab0f29365279
# test job: [e3b47c2bac46fc506ecef42040afa3a91776f722] https://lava.sirena.=
org.uk/scheduler/job/1548653
# good: [e3b47c2bac46fc506ecef42040afa3a91776f722] Merge branch 'for-next' =
of git://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git
git bisect good e3b47c2bac46fc506ecef42040afa3a91776f722
# test job: [eab3a69ec865243607c349518c09fe39ecc0d936] https://lava.sirena.=
org.uk/scheduler/job/1548704
# bad: [eab3a69ec865243607c349518c09fe39ecc0d936] Merge branch 'for-next' o=
f git://git.kernel.org/pub/scm/linux/kernel/git/fpga/linux-fpga.git
git bisect bad eab3a69ec865243607c349518c09fe39ecc0d936
# test job: [022880fb3d8f45e408bb117e634edbe9fb1528b2] https://lava.sirena.=
org.uk/scheduler/job/1548782
# bad: [022880fb3d8f45e408bb117e634edbe9fb1528b2] Merge branch 'next' of gi=
t://git.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm.git
git bisect bad 022880fb3d8f45e408bb117e634edbe9fb1528b2
# test job: [a00a9a8b710f09cc6d05a0189e3cd5e41ff8f467] https://lava.sirena.=
org.uk/scheduler/job/1548826
# bad: [a00a9a8b710f09cc6d05a0189e3cd5e41ff8f467] Merge branch into tip/mas=
ter: 'x86/kconfig'
git bisect bad a00a9a8b710f09cc6d05a0189e3cd5e41ff8f467
# test job: [05f88a899228a24c1beba9291f63895746351a86] https://lava.sirena.=
org.uk/scheduler/job/1549063
# good: [05f88a899228a24c1beba9291f63895746351a86] Merge branch into tip/ma=
ster: 'irq/drivers'
git bisect good 05f88a899228a24c1beba9291f63895746351a86
# test job: [7893ea1006fcbb876ddf53ad4ebba4a054add4b2] https://lava.sirena.=
org.uk/scheduler/job/1549165
# bad: [7893ea1006fcbb876ddf53ad4ebba4a054add4b2] vdso/gettimeofday: Add su=
pport for auxiliary clocks
git bisect bad 7893ea1006fcbb876ddf53ad4ebba4a054add4b2
# test job: [60ecc26ec5af567a55f362ad92c0cac8b894541c] https://lava.sirena.=
org.uk/scheduler/job/1549250
# good: [60ecc26ec5af567a55f362ad92c0cac8b894541c] timekeeping: Provide tim=
e setter for auxiliary clocks
git bisect good 60ecc26ec5af567a55f362ad92c0cac8b894541c
# test job: [d878e2960cb638faf3cc9f1409c6a2a3f9283ec1] https://lava.sirena.=
org.uk/scheduler/job/1549360
# good: [d878e2960cb638faf3cc9f1409c6a2a3f9283ec1] vdso/vsyscall: Introduce=
 a helper to fill clock configurations
git bisect good d878e2960cb638faf3cc9f1409c6a2a3f9283ec1
# test job: [b5df72706b044b30b17f5d623fe040b83e98be36] https://lava.sirena.=
org.uk/scheduler/job/1549506
# bad: [b5df72706b044b30b17f5d623fe040b83e98be36] vdso/gettimeofday: Introd=
uce vdso_clockid_valid()
git bisect bad b5df72706b044b30b17f5d623fe040b83e98be36
# test job: [9916785ef2ce464edd83fce80eaa11fab7792547] https://lava.sirena.=
org.uk/scheduler/job/1549963
# good: [9916785ef2ce464edd83fce80eaa11fab7792547] vdso/helpers: Add helper=
s for seqlocks of single vdso_clock
git bisect good 9916785ef2ce464edd83fce80eaa11fab7792547
# test job: [fcc8e46f768ff508dab0e3cfc2001e96dcb388e2] https://lava.sirena.=
org.uk/scheduler/job/1550140
# bad: [fcc8e46f768ff508dab0e3cfc2001e96dcb388e2] vdso/gettimeofday: Return=
 bool from clock_gettime() helpers
git bisect bad fcc8e46f768ff508dab0e3cfc2001e96dcb388e2
# test job: [7413d7c640aa1d9620aa467922cfe3b8df51272e] https://lava.sirena.=
org.uk/scheduler/job/1550370
# good: [7413d7c640aa1d9620aa467922cfe3b8df51272e] vdso/gettimeofday: Retur=
n bool from clock_getres() helpers
git bisect good 7413d7c640aa1d9620aa467922cfe3b8df51272e
# first bad commit: [fcc8e46f768ff508dab0e3cfc2001e96dcb388e2] vdso/gettime=
ofday: Return bool from clock_gettime() helpers

--8p2AxLcgYrx+Az4a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmhuKFwACgkQJNaLcl1U
h9A8Hgf/eQnWBd0thkQmYSomYPcOxeGXekwCKKMUwRubHkWI1GDfLMIJjs54KZ7b
BWq+w+VURZSr0+pfHIk9UNyC4k+e5n950jaY4bZx7nMwuTKMxC5nF7Rnmkgr5R2q
CLGCrr0IepDrhQiwtVCvR0rujQRAXvB52xfaKDv+kf5K9vgU8+E+rzkg2O4CnBYX
vEeN7T0WqQwk4hmpszqq8QaFgCBSzvZADjzzp/7TrJPR/Yq+ToyDcwbdWQNsMe43
fpDz+RnzLz3nj7tNQRp0phJw2pkf0m3u69VUHwDLds61Jub3RXKHYKfkQDogAyPj
jmdqP5Fi5NLS6geYAFGhfkRmdO+BGg==
=mUjh
-----END PGP SIGNATURE-----

--8p2AxLcgYrx+Az4a--

